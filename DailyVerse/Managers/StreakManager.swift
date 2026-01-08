import Foundation

final class StreakManager {
    struct Snapshot: Equatable {
        let current: Int
        let longest: Int
        let milestones: [StreakMilestone]
    }

    struct DayStatus: Identifiable, Equatable {
        let id = UUID()
        let date: Date
        let isComplete: Bool
    }

    enum StreakMilestone: Int, CaseIterable {
        case three = 3
        case seven = 7
        case thirty = 30

        var label: String {
            switch self {
            case .three: return "3 days"
            case .seven: return "7 days"
            case .thirty: return "30 days"
            }
        }

        var icon: String {
            switch self {
            case .three: return "sparkles"
            case .seven: return "sun.max"
            case .thirty: return "trophy"
            }
        }
    }

    private enum Keys {
        static let currentStreak = "streak.current"
        static let longestStreak = "streak.longest"
        static let lastReadDate = "streak.lastReadDate"
        static let readDates = "streak.readDates"
    }

    private let defaults: UserDefaults
    private let calendar: Calendar
    private let storageFormatter: DateFormatter

    init(defaults: UserDefaults = .standard, calendar: Calendar = .current) {
        self.defaults = defaults
        self.calendar = calendar
        self.storageFormatter = DateFormatter()
        self.storageFormatter.calendar = calendar
        self.storageFormatter.timeZone = calendar.timeZone
        self.storageFormatter.dateFormat = "yyyy-MM-dd"
    }

    var currentStreak: Int {
        defaults.integer(forKey: Keys.currentStreak)
    }

    var longestStreak: Int {
        defaults.integer(forKey: Keys.longestStreak)
    }

    var lastReadDate: Date? {
        defaults.object(forKey: Keys.lastReadDate) as? Date
    }

    func hasRead(on date: Date) -> Bool {
        readDateSet.contains(storageFormatter.string(from: date))
    }

    func snapshot() -> Snapshot {
        Snapshot(current: currentStreak, longest: longestStreak, milestones: milestones(for: currentStreak))
    }

    @discardableResult
    func markRead(on date: Date) -> Snapshot {
        if hasRead(on: date) {
            return snapshot()
        }

        let newCurrent: Int
        if let previous = lastReadDate,
           let consecutiveDate = calendar.date(byAdding: .day, value: -1, to: date),
           calendar.isDate(previous, inSameDayAs: consecutiveDate) {
            newCurrent = currentStreak + 1
        } else {
            newCurrent = 1
        }

        defaults.set(newCurrent, forKey: Keys.currentStreak)
        defaults.set(date, forKey: Keys.lastReadDate)

        let newLongest = max(longestStreak, newCurrent)
        defaults.set(newLongest, forKey: Keys.longestStreak)

        updateReadDates(with: date)

        return Snapshot(current: newCurrent, longest: newLongest, milestones: milestones(for: newCurrent))
    }

    func recentDayStatuses(days: Int, referenceDate: Date = Date()) -> [DayStatus] {
        guard days > 0 else { return [] }

        var statuses: [DayStatus] = []
        for offset in stride(from: days - 1, through: 0, by: -1) {
            guard let day = calendar.date(byAdding: .day, value: -offset, to: referenceDate) else { continue }
            let key = storageFormatter.string(from: day)
            statuses.append(DayStatus(date: day, isComplete: readDateSet.contains(key)))
        }
        return statuses
    }

    func reset() {
        defaults.removeObject(forKey: Keys.currentStreak)
        defaults.removeObject(forKey: Keys.longestStreak)
        defaults.removeObject(forKey: Keys.lastReadDate)
        defaults.removeObject(forKey: Keys.readDates)
    }

    // MARK: - Private helpers

    private var readDateSet: Set<String> {
        get {
            let stored = defaults.array(forKey: Keys.readDates) as? [String] ?? []
            return Set(stored)
        }
        set {
            defaults.set(Array(newValue), forKey: Keys.readDates)
        }
    }

    private func updateReadDates(with date: Date) {
        var set = readDateSet
        let key = storageFormatter.string(from: date)
        set.insert(key)

        if let cutoff = calendar.date(byAdding: .day, value: -90, to: date) {
            let cutoffKey = storageFormatter.string(from: cutoff)
            set = Set(set.filter { $0 >= cutoffKey })
        }

        readDateSet = set
    }

    private func milestones(for streak: Int) -> [StreakMilestone] {
        StreakMilestone.allCases.filter { streak >= $0.rawValue }
    }
}
