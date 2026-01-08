import Foundation
import SwiftUI

@MainActor
final class ReadingHistoryStore: ObservableObject {
    @Published private(set) var events: [ReadingEvent] = []
    
    private let storageKey = "readingHistory"
    private let dedupeWindow: TimeInterval = 60 // 60 seconds
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        load()
    }
    
    func record(book: String, chapter: Int, verses: [Int]) {
        let event = ReadingEvent(
            id: UUID(),
            date: Date(),
            book: book,
            chapter: chapter,
            verses: verses
        )
        
        // Dedupe: if same book/chapter within 60 seconds, merge verses
        if let lastEvent = events.last,
           lastEvent.book == book,
           lastEvent.chapter == chapter,
           event.date.timeIntervalSince(lastEvent.date) < dedupeWindow {
            // Merge verses
            var mergedVerses = Set(lastEvent.verses)
            mergedVerses.formUnion(verses)
            let mergedEvent = ReadingEvent(
                id: lastEvent.id,
                date: lastEvent.date,
                book: book,
                chapter: chapter,
                verses: Array(mergedVerses).sorted()
            )
            events[events.count - 1] = mergedEvent
        } else {
            events.append(event)
        }
        
        save()
    }
    
    func exportJSON() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        guard let data = try? encoder.encode(events),
              let jsonString = String(data: data, encoding: .utf8) else {
            return "[]"
        }
        return jsonString
    }
    
    func clear() {
        events.removeAll()
        save()
    }
    
    private func save() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        if let data = try? encoder.encode(events) {
            defaults.set(data, forKey: storageKey)
        }
    }
    
    private func load() {
        guard let data = defaults.data(forKey: storageKey) else {
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        if let decoded = try? decoder.decode([ReadingEvent].self, from: data) {
            events = decoded
        }
    }
}

