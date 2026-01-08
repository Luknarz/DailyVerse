import Foundation

struct BibleReferenceParser {
    /// Parses a Bible reference string (e.g., "Psalm 23:1", "John 1:1-3", "Matthew 5:14")
    /// Returns (book, chapter, verses)
    static func parse(_ reference: String) -> (book: String, chapter: Int, verses: [Int])? {
        // Pattern: Book Name Chapter:Verse(s)
        // Examples: "Psalm 23:1", "John 1:1", "1 Corinthians 15:3-5"
        
        let trimmed = reference.trimmingCharacters(in: .whitespaces)
        
        // Find the last colon (separates chapter from verses)
        guard let colonIndex = trimmed.lastIndex(of: ":") else {
            return nil
        }
        
        let beforeColon = String(trimmed[..<colonIndex]).trimmingCharacters(in: .whitespaces)
        let afterColon = String(trimmed[trimmed.index(after: colonIndex)...]).trimmingCharacters(in: .whitespaces)
        
        // Extract chapter number (last number before colon)
        // Find the last sequence of digits in beforeColon
        var chapter: Int?
        var chapterStartIndex: String.Index?
        
        var currentIndex = beforeColon.endIndex
        while currentIndex > beforeColon.startIndex {
            let previousIndex = beforeColon.index(before: currentIndex)
            let char = beforeColon[previousIndex]
            
            if char.isNumber {
                // Found a digit, find the start of this number sequence
                var numberStart = previousIndex
                while numberStart > beforeColon.startIndex {
                    let prev = beforeColon.index(before: numberStart)
                    if beforeColon[prev].isNumber {
                        numberStart = prev
                    } else {
                        break
                    }
                }
                
                // Extract the number
                let numberString = String(beforeColon[numberStart..<currentIndex])
                if let num = Int(numberString) {
                    chapter = num
                    chapterStartIndex = numberStart
                    break
                }
            }
            
            currentIndex = previousIndex
        }
        
        guard let chapterValue = chapter, let startIndex = chapterStartIndex else {
            return nil
        }
        
        // Extract book name (everything before the chapter number starts)
        let book = String(beforeColon[..<startIndex]).trimmingCharacters(in: .whitespaces)
        guard !book.isEmpty else {
            return nil
        }
        
        // Ensure book name is not just a number (e.g., "23:1" should fail)
        guard !book.allSatisfy({ $0.isNumber || $0.isWhitespace }) else {
            return nil
        }
        
        // Parse verses (can be single verse, range, or comma-separated)
        var verses: [Int] = []
        let verseParts = afterColon.split(separator: ",")
        
        for part in verseParts {
            let trimmedPart = part.trimmingCharacters(in: .whitespaces)
            
            // Check for range (e.g., "1-3")
            if let dashIndex = trimmedPart.firstIndex(of: "-") {
                let startStr = String(trimmedPart[..<dashIndex]).trimmingCharacters(in: .whitespaces)
                let endStr = String(trimmedPart[trimmedPart.index(after: dashIndex)...]).trimmingCharacters(in: .whitespaces)
                
                if let start = Int(startStr), let end = Int(endStr), start <= end {
                    verses.append(contentsOf: Array(start...end))
                }
            } else if let verse = Int(trimmedPart) {
                verses.append(verse)
            }
        }
        
        return (book: book, chapter: chapterValue, verses: verses.sorted())
    }
}

