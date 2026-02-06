import SwiftUI

enum ReadingMode: String {
    case `default`
    case night
    case sepia
}

struct ReadingTheme {
    let mode: ReadingMode

    var colorScheme: ColorScheme? {
        switch mode {
        case .night:
            return .dark
        case .sepia:
            return .light
        case .default:
            return nil
        }
    }

    var background: Color {
        switch mode {
        case .default:
            return Color(.systemBackground)
        case .night:
            return Color(.sRGB, red: 0.06, green: 0.06, blue: 0.07, opacity: 1.0)
        case .sepia:
            return Color(.sRGB, red: 0.97, green: 0.94, blue: 0.88, opacity: 1.0)
        }
    }

    var surface: Color {
        switch mode {
        case .default:
            return Color(.secondarySystemBackground)
        case .night:
            return Color(.sRGB, red: 0.12, green: 0.12, blue: 0.14, opacity: 1.0)
        case .sepia:
            return Color(.sRGB, red: 0.99, green: 0.96, blue: 0.90, opacity: 1.0)
        }
    }

    var accent: Color {
        switch mode {
        case .default:
            return Color.accentColor
        case .night:
            return Color(.sRGB, red: 0.35, green: 0.62, blue: 1.0, opacity: 1.0)
        case .sepia:
            return Color(.sRGB, red: 0.66, green: 0.43, blue: 0.20, opacity: 1.0)
        }
    }
}

extension ReadingTheme {
    static func from(rawValue: String) -> ReadingTheme {
        let mode = ReadingMode(rawValue: rawValue) ?? .default
        return ReadingTheme(mode: mode)
    }
}
