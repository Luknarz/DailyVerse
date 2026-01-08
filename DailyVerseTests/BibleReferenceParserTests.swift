import XCTest
@testable import DailyVerse

final class BibleReferenceParserTests: XCTestCase {
    
    func testParseSimpleReference() {
        let result = BibleReferenceParser.parse("Psalm 23:1")
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.book, "Psalm")
        XCTAssertEqual(result?.chapter, 23)
        XCTAssertEqual(result?.verses, [1])
    }
    
    func testParseReferenceWithMultipleVerses() {
        let result = BibleReferenceParser.parse("John 1:1-3")
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.book, "John")
        XCTAssertEqual(result?.chapter, 1)
        XCTAssertEqual(result?.verses, [1, 2, 3])
    }
    
    func testParseReferenceWithCommaSeparatedVerses() {
        let result = BibleReferenceParser.parse("Matthew 5:14,16")
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.book, "Matthew")
        XCTAssertEqual(result?.chapter, 5)
        XCTAssertEqual(result?.verses, [14, 16])
    }
    
    func testParseReferenceWithComplexRange() {
        let result = BibleReferenceParser.parse("1 Corinthians 15:3-5,7")
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.book, "1 Corinthians")
        XCTAssertEqual(result?.chapter, 15)
        XCTAssertEqual(result?.verses, [3, 4, 5, 7])
    }
    
    func testParseInvalidReferenceReturnsNil() {
        XCTAssertNil(BibleReferenceParser.parse("Invalid"))
        XCTAssertNil(BibleReferenceParser.parse("Psalm"))
        XCTAssertNil(BibleReferenceParser.parse("23:1"))
        XCTAssertNil(BibleReferenceParser.parse(""))
    }
    
    func testParseReferenceWithWhitespace() {
        let result = BibleReferenceParser.parse("  Psalm  23 : 1  ")
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.book, "Psalm")
        XCTAssertEqual(result?.chapter, 23)
        XCTAssertEqual(result?.verses, [1])
    }
    
    func testParseReferenceWithInvalidRange() {
        let result = BibleReferenceParser.parse("John 1:5-3") // Invalid: end < start
        XCTAssertNotNil(result)
        // Should still parse but may not include invalid range
        XCTAssertEqual(result?.book, "John")
        XCTAssertEqual(result?.chapter, 1)
    }
}

