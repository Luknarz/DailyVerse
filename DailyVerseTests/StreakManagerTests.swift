import XCTest
@testable import DailyVerse

final class StreakManagerTests: XCTestCase {
    private var defaults: UserDefaults!
    private var calendar: Calendar!
    private var manager: StreakManager!

    override func setUp() {
        super.setUp()
        defaults = UserDefaults(suiteName: "StreakManagerTests")
        defaults.removePersistentDomain(forName: "StreakManagerTests")
        calendar = Calendar(identifier: .gregorian)
        manager = StreakManager(defaults: defaults, calendar: calendar)
    }

    override func tearDown() {
        defaults.removePersistentDomain(forName: "StreakManagerTests")
        defaults = nil
        manager = nil
        calendar = nil
        super.tearDown()
    }

    func testStreakStartsAtOne() {
        let date = Date()
        let snapshot = manager.markRead(on: date)
        XCTAssertEqual(snapshot.current, 1)
        XCTAssertEqual(manager.currentStreak, 1)
    }

    func testConsecutiveDaysIncreaseStreak() {
        let today = Date()
        _ = manager.markRead(on: today)
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        let snapshot = manager.markRead(on: tomorrow)
        XCTAssertEqual(snapshot.current, 2)
    }

    func testMissingDayResetsStreak() {
        let start = Date()
        _ = manager.markRead(on: start)
        let twoDaysLater = calendar.date(byAdding: .day, value: 2, to: start)!
        let snapshot = manager.markRead(on: twoDaysLater)
        XCTAssertEqual(snapshot.current, 1)
    }

    func testDuplicateDayDoesNotIncrement() {
        let today = Date()
        _ = manager.markRead(on: today)
        let streak = manager.markRead(on: today)
        XCTAssertEqual(streak.current, 1)
    }

    // MARK: - Longest Streak Tests

    func testLongestStreakStartsAtZero() {
        XCTAssertEqual(manager.longestStreak, 0)
    }

    func testLongestStreakUpdatesWhenCurrentExceeds() {
        let start = Date()
        var snapshot = manager.markRead(on: start)
        XCTAssertEqual(snapshot.longest, 1)

        for day in 1...5 {
            let nextDay = calendar.date(byAdding: .day, value: day, to: start)!
            snapshot = manager.markRead(on: nextDay)
        }

        XCTAssertEqual(snapshot.current, 6)
        XCTAssertEqual(snapshot.longest, 6)
        XCTAssertEqual(manager.longestStreak, 6)
    }

    func testLongestStreakPersistsAfterReset() {
        let start = Date()
        for day in 0...4 {
            let date = calendar.date(byAdding: .day, value: day, to: start)!
            _ = manager.markRead(on: date)
        }

        XCTAssertEqual(manager.currentStreak, 5)
        XCTAssertEqual(manager.longestStreak, 5)

        // Skip day 5, mark day 6 (2 days after the last read day 4)
        let skippedDay = calendar.date(byAdding: .day, value: 6, to: start)!
        _ = manager.markRead(on: skippedDay)

        XCTAssertEqual(manager.currentStreak, 1)
        XCTAssertEqual(manager.longestStreak, 5)
    }

    func testLongestStreakOnlyIncreases() {
        let start = Date()
        for day in 0...3 {
            let date = calendar.date(byAdding: .day, value: day, to: start)!
            _ = manager.markRead(on: date)
        }

        XCTAssertEqual(manager.longestStreak, 4)

        let skippedDay = calendar.date(byAdding: .day, value: 5, to: start)!
        _ = manager.markRead(on: skippedDay)

        XCTAssertEqual(manager.currentStreak, 1)
        XCTAssertEqual(manager.longestStreak, 4)

        for day in 1...2 {
            let date = calendar.date(byAdding: .day, value: day, to: skippedDay)!
            _ = manager.markRead(on: date)
        }

        XCTAssertEqual(manager.currentStreak, 3)
        XCTAssertEqual(manager.longestStreak, 4)
    }

    // MARK: - Milestone Tests

    func testNoMilestonesAtStart() {
        let snapshot = manager.markRead(on: Date())
        XCTAssertTrue(snapshot.milestones.isEmpty)
    }

    func testThreeDayMilestone() {
        let start = Date()
        for day in 0...2 {
            let date = calendar.date(byAdding: .day, value: day, to: start)!
            let snapshot = manager.markRead(on: date)
            if day == 2 {
                XCTAssertEqual(snapshot.milestones.count, 1)
                XCTAssertEqual(snapshot.milestones.first, .three)
            }
        }
    }

    func testSevenDayMilestone() {
        let start = Date()
        var snapshot: StreakManager.Snapshot!
        for day in 0...6 {
            let date = calendar.date(byAdding: .day, value: day, to: start)!
            snapshot = manager.markRead(on: date)
        }

        XCTAssertEqual(snapshot.milestones.count, 2)
        XCTAssertTrue(snapshot.milestones.contains(.three))
        XCTAssertTrue(snapshot.milestones.contains(.seven))
    }

    func testThirtyDayMilestone() {
        let start = Date()
        var snapshot: StreakManager.Snapshot!
        for day in 0...29 {
            let date = calendar.date(byAdding: .day, value: day, to: start)!
            snapshot = manager.markRead(on: date)
        }

        XCTAssertEqual(snapshot.milestones.count, 3)
        XCTAssertTrue(snapshot.milestones.contains(.three))
        XCTAssertTrue(snapshot.milestones.contains(.seven))
        XCTAssertTrue(snapshot.milestones.contains(.thirty))
    }

    func testMilestonesPersistAfterStreakReset() {
        let start = Date()
        for day in 0...6 {
            let date = calendar.date(byAdding: .day, value: day, to: start)!
            _ = manager.markRead(on: date)
        }

        let snapshot = manager.snapshot()
        XCTAssertEqual(snapshot.milestones.count, 2)

        let skippedDay = calendar.date(byAdding: .day, value: 8, to: start)!
        let resetSnapshot = manager.markRead(on: skippedDay)

        XCTAssertEqual(resetSnapshot.current, 1)
        XCTAssertEqual(resetSnapshot.milestones.count, 0)
    }

    // MARK: - Recent Day Status Tests

    func testRecentDayStatusesShowsReadDays() {
        let start = Date()
        _ = manager.markRead(on: start)

        let yesterday = calendar.date(byAdding: .day, value: -1, to: start)!
        _ = manager.markRead(on: yesterday)

        let statuses = manager.recentDayStatuses(days: 7, referenceDate: start)
        XCTAssertEqual(statuses.count, 7)

        let yesterdayStatus = statuses.first { calendar.isDate($0.date, inSameDayAs: yesterday) }
        XCTAssertNotNil(yesterdayStatus)
        XCTAssertTrue(yesterdayStatus?.isComplete ?? false)

        let todayStatus = statuses.first { calendar.isDate($0.date, inSameDayAs: start) }
        XCTAssertNotNil(todayStatus)
        XCTAssertTrue(todayStatus?.isComplete ?? false)
    }

    func testRecentDayStatusesShowsMissedDays() {
        let start = Date()
        _ = manager.markRead(on: start)

        let threeDaysAgo = calendar.date(byAdding: .day, value: -3, to: start)!
        _ = manager.markRead(on: threeDaysAgo)

        let statuses = manager.recentDayStatuses(days: 7, referenceDate: start)
        XCTAssertEqual(statuses.count, 7)

        let yesterdayStatus = statuses.first { calendar.isDate($0.date, inSameDayAs: calendar.date(byAdding: .day, value: -1, to: start)!) }
        XCTAssertNotNil(yesterdayStatus)
        XCTAssertFalse(yesterdayStatus?.isComplete ?? true)

        let threeDaysAgoStatus = statuses.first { calendar.isDate($0.date, inSameDayAs: threeDaysAgo) }
        XCTAssertNotNil(threeDaysAgoStatus)
        XCTAssertTrue(threeDaysAgoStatus?.isComplete ?? false)
    }

    func testRecentDayStatusesEmptyForZeroDays() {
        let statuses = manager.recentDayStatuses(days: 0)
        XCTAssertTrue(statuses.isEmpty)
    }

    // MARK: - Snapshot Tests

    func testSnapshotContainsAllData() {
        let start = Date()
        for day in 0...2 {
            let date = calendar.date(byAdding: .day, value: day, to: start)!
            _ = manager.markRead(on: date)
        }

        let snapshot = manager.snapshot()
        XCTAssertEqual(snapshot.current, 3)
        XCTAssertEqual(snapshot.longest, 3)
        XCTAssertEqual(snapshot.milestones.count, 1)
        XCTAssertEqual(snapshot.milestones.first, .three)
    }

    func testSnapshotUpdatesAfterMarkRead() {
        let start = Date()
        _ = manager.markRead(on: start)

        let tomorrow = calendar.date(byAdding: .day, value: 1, to: start)!
        let snapshot = manager.markRead(on: tomorrow)

        XCTAssertEqual(snapshot.current, 2)
        XCTAssertEqual(snapshot.longest, 2)
        XCTAssertTrue(snapshot.milestones.isEmpty)
    }
}
