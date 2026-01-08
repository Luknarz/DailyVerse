import Foundation

struct ReadingEvent: Identifiable, Codable, Equatable {
    let id: UUID
    let date: Date
    let book: String
    let chapter: Int
    let verses: [Int] // empty array means "chapter viewed"
    
    init(id: UUID = UUID(), date: Date, book: String, chapter: Int, verses: [Int]) {
        self.id = id
        self.date = date
        self.book = book
        self.chapter = chapter
        self.verses = verses
    }
}

