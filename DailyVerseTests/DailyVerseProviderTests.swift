import XCTest
@testable import DailyVerse

final class DailyVerseProviderTests: XCTestCase {
    private var defaults: UserDefaults!
    private var calendar: Calendar!
    private var verseRepository: VerseRepository!
    private var provider: DailyVerseProvider!
    
    override func setUp() {
        super.setUp()
        defaults = UserDefaults(suiteName: "DailyVerseProviderTests")
        defaults.removePersistentDomain(forName: "DailyVerseProviderTests")
        calendar = Calendar(identifier: .gregorian)
        
        // Create a test verse repository with sample data
        verseRepository = createTestVerseRepository()
        provider = DailyVerseProvider(verseRepository: verseRepository, defaults: defaults, calendar: calendar)
    }
    
    override func tearDown() {
        defaults.removePersistentDomain(forName: "DailyVerseProviderTests")
        defaults = nil
        calendar = nil
        verseRepository = nil
        provider = nil
        super.tearDown()
    }
    
    func testVerseForDateAssignsFirstVerse() {
        let date = Date()
        let verse = provider.verse(for: date)
        
        XCTAssertNotNil(verse)
        XCTAssertTrue(provider.hasVerse(for: date))
    }
    
    func testVerseForDateReturnsSameVerseOnSubsequentCalls() {
        let date = Date()
        let verse1 = provider.verse(for: date)
        let verse2 = provider.verse(for: date)
        
        XCTAssertEqual(verse1?.id, verse2?.id)
    }
    
    func testVersesForDateReturnsArray() {
        let date = Date()
        let verses = provider.versesForDate(date)
        
        XCTAssertEqual(verses.count, 1)
        XCTAssertNotNil(verses.first)
    }
    
    func testVersesForTodayReturnsTodayVerses() {
        let todayVerses = provider.versesForToday()
        XCTAssertEqual(todayVerses.count, 1)
    }
    
    func testFetchAdditionalVerseForTodayAppendsVerse() {
        let initialVerses = provider.versesForToday()
        XCTAssertEqual(initialVerses.count, 1)
        
        let additionalVerse = provider.fetchAdditionalVerseForToday()
        XCTAssertNotNil(additionalVerse)
        
        let updatedVerses = provider.versesForToday()
        XCTAssertEqual(updatedVerses.count, 2)
        XCTAssertTrue(updatedVerses.contains { $0.id == initialVerses[0].id })
        XCTAssertTrue(updatedVerses.contains { $0.id == additionalVerse?.id })
    }
    
    func testMultipleVersesPerDayArePersisted() {
        let date = Date()
        _ = provider.versesForDate(date)
        _ = provider.fetchAdditionalVerseForToday()
        
        // Create new provider instance to test persistence
        let newProvider = DailyVerseProvider(verseRepository: verseRepository, defaults: defaults, calendar: calendar)
        let persistedVerses = newProvider.versesForDate(date)
        
        XCTAssertEqual(persistedVerses.count, 2)
    }
    
    func testDifferentDatesGetDifferentVerses() {
        let today = Date()
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        let todayVerse = provider.verse(for: today)
        let tomorrowVerse = provider.verse(for: tomorrow)
        
        XCTAssertNotNil(todayVerse)
        XCTAssertNotNil(tomorrowVerse)
        XCTAssertNotEqual(todayVerse?.id, tomorrowVerse?.id)
    }
    
    func testHasVerseReturnsFalseForUnassignedDate() {
        let futureDate = calendar.date(byAdding: .day, value: 100, to: Date())!
        XCTAssertFalse(provider.hasVerse(for: futureDate))
    }
    
    func testMigrationFromOldFormat() {
        // Simulate old format data
        let oldFormat: [String: Int] = ["2025-01-01": 0, "2025-01-02": 1]
        if let data = try? JSONEncoder().encode(oldFormat) {
            defaults.set(data, forKey: "dailyVerseProvider.dateToVerseMapping")
        }
        
        // Create new provider - should migrate
        let migratedProvider = DailyVerseProvider(verseRepository: verseRepository, defaults: defaults, calendar: calendar)
        let date1 = calendar.date(from: DateComponents(year: 2025, month: 1, day: 1))!
        let date2 = calendar.date(from: DateComponents(year: 2025, month: 1, day: 2))!
        
        let verses1 = migratedProvider.versesForDate(date1)
        let verses2 = migratedProvider.versesForDate(date2)
        
        XCTAssertEqual(verses1.count, 1)
        XCTAssertEqual(verses2.count, 1)
        
        // Old key should be removed
        XCTAssertNil(defaults.data(forKey: "dailyVerseProvider.dateToVerseMapping"))
    }
    
    // MARK: - Helper
    
    private func createTestVerseRepository() -> VerseRepository {
        let testDefaults = UserDefaults(suiteName: "TestVerseRepository")!
        testDefaults.removePersistentDomain(forName: "TestVerseRepository")
        return VerseRepository(bundle: .main, defaults: testDefaults)
    }
}

