import Foundation

struct Verse: Identifiable, Codable, Equatable {
    let id: Int
    let reference: String
    let text: String
    let book: String
    let chapter: Int
    let verse: Int
}

