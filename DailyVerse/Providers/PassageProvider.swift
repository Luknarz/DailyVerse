import Foundation

final class PassageProvider {
    private let bundle: Bundle
    private let passages: [DailyPassage]
    private let calendar: Calendar

    init(bundle: Bundle = .main, calendar: Calendar = .current) {
        self.bundle = bundle
        self.calendar = calendar
        self.passages = PassageProvider.loadPassages(from: bundle)
    }

    func passage(for date: Date) -> DailyPassage? {
        guard !passages.isEmpty else { return nil }

        // Normalize date to midnight to ensure consistent comparison
        let normalizedDate = calendar.startOfDay(for: date)
        let formattedDate = DailyPassage.dateFormatter.string(from: normalizedDate)
        
        if let exactMatch = passages.first(where: { DailyPassage.dateFormatter.string(from: $0.date) == formattedDate }) {
            return exactMatch
        }

        let dayIndex = calendar.ordinality(of: .day, in: .year, for: normalizedDate).map { $0 - 1 } ?? 0
        let normalized = dayIndex % passages.count
        return passages[normalized]
    }

    func allPassages() -> [DailyPassage] {
        passages
    }

    private static func loadPassages(from bundle: Bundle) -> [DailyPassage] {
        guard let url = bundle.url(forResource: "passages", withExtension: "json") else {
            assertionFailure("passages.json missing from bundle")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([DailyPassage].self, from: data)
        } catch {
            assertionFailure("Failed to decode passages.json: \(error)")
            return []
        }
    }
}
