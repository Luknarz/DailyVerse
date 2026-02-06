import Foundation
import SwiftUI
import UIKit

@MainActor
final class DailyPassageViewModel: ObservableObject {
    @Published private(set) var todaysVerses: [Verse] = []
    @Published private(set) var streakCount: Int = 0
    @Published private(set) var longestStreak: Int = 0
    @Published private(set) var hasReadToday: Bool = false
    @Published private(set) var achievedMilestones: [StreakManager.StreakMilestone] = []
    @Published private(set) var recentStatuses: [StreakManager.DayStatus] = []

    private let dailyVerseProvider: DailyVerseProvider
    private let streakManager: StreakManager
    private let calendar: Calendar

    init(dailyVerseProvider: DailyVerseProvider = DailyVerseProvider(),
         streakManager: StreakManager = StreakManager(),
         calendar: Calendar = .current) {
        self.dailyVerseProvider = dailyVerseProvider
        self.streakManager = streakManager
        self.calendar = calendar
        loadToday()
    }

    func loadToday(date: Date = Date()) {
        todaysVerses = dailyVerseProvider.versesForDate(date)
        streakCount = streakManager.currentStreak
        longestStreak = streakManager.longestStreak
        hasReadToday = streakManager.hasRead(on: date)
        achievedMilestones = streakManager.snapshot().milestones
        recentStatuses = streakManager.recentDayStatuses(days: 14, referenceDate: date)
    }
    
    /// Fetches an additional verse for today and updates the published property
    func fetchAdditionalVerseForToday() {
        guard let newVerse = dailyVerseProvider.fetchAdditionalVerseForToday() else {
            return
        }
        todaysVerses.append(newVerse)
    }
    
    /// Backward compatibility: returns the first verse
    var todaysVerse: Verse? {
        return todaysVerses.first
    }

    func markAsRead(date: Date = Date()) {
        let snapshot = streakManager.markRead(on: date)
        streakCount = snapshot.current
        longestStreak = snapshot.longest
        achievedMilestones = snapshot.milestones
        hasReadToday = true
        recentStatuses = streakManager.recentDayStatuses(days: 14, referenceDate: date)
    }

    func resetStreak() {
        streakManager.reset()
        streakCount = 0
        longestStreak = 0
        hasReadToday = false
        achievedMilestones = []
        recentStatuses = []
    }

    var shareStreakText: String {
        guard streakCount > 0 else { return "Join my Daily Verse Reading journey!" }
        return "🔥 \(streakCount)-day streak!"
    }
    
    // MARK: - Per-Verse Actions
    
    func share(verse: Verse) -> UIImage? {
        return renderShareImage(
            text: verse.text,
            reference: verse.reference,
            streakText: nil
        )
    }
    
    func copy(verse: Verse) {
        let text = "\(verse.text)\n— \(verse.reference)"
        UIPasteboard.general.string = text
    }
    
    func shareAllVersesAsText() -> String {
        let versesText = todaysVerses.map { "\($0.text)\n— \($0.reference)" }.joined(separator: "\n\n")
        return versesText
    }
    
    func shareMultipleVerses(_ verses: [Verse]) -> [UIImage] {
        return verses.compactMap { share(verse: $0) }
    }
    
    func shareMultipleVersesAsText(_ verses: [Verse]) -> String {
        return verses.map { "\($0.text)\n— \($0.reference)" }.joined(separator: "\n\n")
    }
}
