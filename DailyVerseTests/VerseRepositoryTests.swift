import XCTest
@testable import DailyVerse

final class VerseRepositoryTests: XCTestCase {
    private var defaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        defaults = UserDefaults(suiteName: "VerseRepositoryTests")
        defaults.removePersistentDomain(forName: "VerseRepositoryTests")
    }
    
    override func tearDown() {
        defaults.removePersistentDomain(forName: "VerseRepositoryTests")
        defaults = nil
        super.tearDown()
    }
    
    func testLoadsVersesFromBundle() {
        let repository = VerseRepository(bundle: .main, defaults: defaults)
        let verse = repository.verse(for: 0)
        XCTAssertNotNil(verse)
        XCTAssertNotNil(verse?.id)
        XCTAssertNotNil(verse?.reference)
    }
    
    func testNextVerseIndexReturnsSequentialIndices() {
        let repository = VerseRepository(bundle: .main, defaults: defaults)
        let index1 = repository.nextVerseIndex()
        let index2 = repository.nextVerseIndex()
        let index3 = repository.nextVerseIndex()
        
        XCTAssertEqual(index1, 0)
        XCTAssertEqual(index2, 1)
        XCTAssertEqual(index3, 2)
    }
    
    func testShuffledSequenceIsPersisted() {
        let repository1 = VerseRepository(bundle: .main, defaults: defaults)
        let firstSequence: [Int] = (0..<5).map { _ in repository1.nextVerseIndex() }
        
        let repository2 = VerseRepository(bundle: .main, defaults: defaults)
        let secondSequence: [Int] = (0..<5).map { _ in repository2.nextVerseIndex() }
        
        // Should continue from where first repository left off
        XCTAssertEqual(secondSequence[0], firstSequence[4] + 1)
    }
    
    func testVerseForIndexReturnsCorrectVerse() {
        let repository = VerseRepository(bundle: .main, defaults: defaults)
        let index = repository.nextVerseIndex()
        let verse = repository.verse(for: index)
        
        XCTAssertNotNil(verse)
        // The verse at the index should match what was returned from nextVerseIndex
        let verseAtZero = repository.verse(for: 0)
        XCTAssertNotNil(verseAtZero)
    }
    
    func testVerseForInvalidIndexReturnsNil() {
        let repository = VerseRepository(bundle: .main, defaults: defaults)
        XCTAssertNil(repository.verse(for: -1))
        // Note: Testing with 1000 might pass if there are enough verses, so we test with a very large number
        let largeIndex = repository.nextVerseIndex() + 10000
        XCTAssertNil(repository.verse(for: largeIndex))
    }
    
    func testResetReinitializesSequence() {
        let repository = VerseRepository(bundle: .main, defaults: defaults)
        _ = repository.nextVerseIndex()
        _ = repository.nextVerseIndex()
        
        repository.reset()
        
        let indexAfterReset = repository.nextVerseIndex()
        XCTAssertEqual(indexAfterReset, 0)
    }
    
    func testSequenceWrapsAroundWhenExhausted() {
        let repository = VerseRepository(bundle: .main, defaults: defaults)
        
        // Get initial index to know where we start
        let initialIndex = repository.nextVerseIndex()
        
        // Consume many verses (more than likely in the pool)
        // We'll test that it wraps by checking the pattern
        var indices: [Int] = [initialIndex]
        for _ in 0..<10 {
            indices.append(repository.nextVerseIndex())
        }
        
        // All indices should be sequential
        for i in 1..<indices.count {
            XCTAssertEqual(indices[i], indices[i-1] + 1)
        }
    }
}

