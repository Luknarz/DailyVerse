import Foundation

struct DailyPassage: Identifiable, Codable, Equatable {
    let id: UUID
    let date: Date
    let reference: String
    let text: String

    enum CodingKeys: String, CodingKey {
        case date
        case reference
        case text
    }

    init(id: UUID = UUID(), date: Date, reference: String, text: String) {
        self.id = id
        self.date = date
        self.reference = reference
        self.text = text
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateString = try container.decode(String.self, forKey: .date)
        guard let parsedDate = DailyPassage.dateFormatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(
                forKey: .date,
                in: container,
                debugDescription: "Invalid date format: \(dateString)"
            )
        }
        self.date = parsedDate
        self.reference = try container.decode(String.self, forKey: .reference)
        self.text = try container.decode(String.self, forKey: .text)
        self.id = UUID()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let dateString = DailyPassage.dateFormatter.string(from: date)
        try container.encode(dateString, forKey: .date)
        try container.encode(reference, forKey: .reference)
        try container.encode(text, forKey: .text)
    }
}

extension DailyPassage {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
