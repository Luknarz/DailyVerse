import Foundation

final class DailyVerseProvider {
    private enum Keys {
        static let dateToVerseMapping = "dailyVerseProvider.dateToVerseMapping"
        static let dateToVerseMappingV2 = "dailyVerseProvider.dateToVerseMappingV2"
    }
    
    private let verseRepository: VerseRepository
    private let defaults: UserDefaults
    private let calendar: Calendar
    
    // Mapping of date string (yyyy-MM-dd) to array of verse indices
    private var dateToVerseMapping: [String: [Int]] = [:]
    
    init(verseRepository: VerseRepository = VerseRepository(),
         defaults: UserDefaults = .standard,
         calendar: Calendar = .current) {
        self.verseRepository = verseRepository
        self.defaults = defaults
        self.calendar = calendar
        loadMapping()
    }
    
    /// Returns the first verse for a given date (for backward compatibility)
    func verse(for date: Date) -> Verse? {
        return versesForDate(date).first
    }
    
    /// Returns all verses assigned for a given date
    func versesForDate(_ date: Date) -> [Verse] {
        let dateKey = dateKey(for: date)
        
        // Check if we already have verses assigned for this date
        if let verseIndices = dateToVerseMapping[dateKey], !verseIndices.isEmpty {
            return verseIndices.compactMap { verseRepository.verse(for: $0) }
        }
        
        // Assign the first verse for this date
        let verseIndex = verseRepository.nextVerseIndex()
        dateToVerseMapping[dateKey] = [verseIndex]
        saveMapping()
        
        return verseRepository.verse(for: verseIndex).map { [$0] } ?? []
    }
    
    /// Returns all verses for today
    func versesForToday() -> [Verse] {
        return versesForDate(Date())
    }
    
    /// Fetches an additional verse for today and appends it to today's verses
    func fetchAdditionalVerseForToday() -> Verse? {
        let dateKey = dateKey(for: Date())
        let verseIndex = verseRepository.nextVerseIndex()
        
        // Get existing verses or create new array
        var existingIndices = dateToVerseMapping[dateKey] ?? []
        existingIndices.append(verseIndex)
        dateToVerseMapping[dateKey] = existingIndices
        saveMapping()
        
        return verseRepository.verse(for: verseIndex)
    }
    
    func hasVerse(for date: Date) -> Bool {
        let dateKey = dateKey(for: date)
        return dateToVerseMapping[dateKey] != nil && !(dateToVerseMapping[dateKey]?.isEmpty ?? true)
    }
    
    // MARK: - Private
    
    private func dateKey(for date: Date) -> String {
        let normalizedDate = calendar.startOfDay(for: date)
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.timeZone = calendar.timeZone
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: normalizedDate)
    }
    
    private func loadMapping() {
        // Try to load new format first
        if let data = defaults.data(forKey: Keys.dateToVerseMappingV2),
           let decoded = try? JSONDecoder().decode([String: [Int]].self, from: data) {
            dateToVerseMapping = decoded
            return
        }
        
        // Migrate from old format (single verse per date) to new format (array)
        if let data = defaults.data(forKey: Keys.dateToVerseMapping),
           let oldFormat = try? JSONDecoder().decode([String: Int].self, from: data) {
            // Convert [String: Int] to [String: [Int]]
            dateToVerseMapping = oldFormat.mapValues { [$0] }
            saveMapping()
            // Remove old key
            defaults.removeObject(forKey: Keys.dateToVerseMapping)
        }
    }
    
    private func saveMapping() {
        if let data = try? JSONEncoder().encode(dateToVerseMapping) {
            defaults.set(data, forKey: Keys.dateToVerseMappingV2)
        }
    }
}

