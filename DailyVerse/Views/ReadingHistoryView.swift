import SwiftUI

struct ReadingHistoryView: View {
    @EnvironmentObject private var history: ReadingHistoryStore
    @EnvironmentObject private var favoriteStore: FavoriteStore
    @EnvironmentObject private var storeManager: StoreManager
    @State private var selectedDate: Date?
    @State private var selectedDateEvents: [ReadingEvent] = []
    @State private var showingPremiumView = false
    @AppStorage("readingMode") private var readingMode = "default"
    
    private let calendar = Calendar.current
    private var currentMonth: Date { Date() }
    
    private var theme: ReadingTheme {
        ReadingTheme.from(rawValue: readingMode)
    }
    
    private var eventsByDate: [String: [ReadingEvent]] {
        Dictionary(grouping: history.events) { event in
            dateKey(for: event.date)
        }
    }
    
    private func dateKey(for date: Date) -> String {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return "\(components.year ?? 0)-\(components.month ?? 0)-\(components.day ?? 0)"
    }
    
    private func hasReading(for date: Date) -> Bool {
        let key = dateKey(for: date)
        return eventsByDate[key] != nil
    }
    
    private func events(for date: Date) -> [ReadingEvent] {
        let key = dateKey(for: date)
        return eventsByDate[key] ?? []
    }
    
    private var monthDays: [Date?] {
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth))!
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        let firstWeekdayOffset = (firstWeekday - calendar.firstWeekday + 7) % 7
        
        let daysInMonth = calendar.range(of: .day, in: .month, for: startOfMonth)!.count
        var days: [Date?] = []
        
        // Add empty cells for days before the first day of the month
        for _ in 0..<firstWeekdayOffset {
            days.append(nil)
        }
        
        // Add all days in the month
        for day in 1...daysInMonth {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                days.append(date)
            }
        }
        
        return days
    }
    
    private var monthYearText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentMonth)
    }
    
    private var weekdayLabels: [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        var labels: [String] = []
        let firstWeekday = calendar.firstWeekday
        
        for i in 0..<7 {
            let weekday = (firstWeekday + i - 1) % 7 + 1
            if let date = calendar.date(bySetting: .weekday, value: weekday, of: Date()) {
                labels.append(formatter.string(from: date))
            }
        }
        return labels
    }
    
    var body: some View {
        Group {
            if storeManager.isPremium {
                readingHistoryContent
            } else {
                premiumLockedContent
            }
        }
        .navigationTitle("Reading History")
        .navigationBarTitleDisplayMode(.large)
        .background(theme.background)
        .preferredColorScheme(theme.colorScheme)
        .tint(theme.accent)
        .sheet(isPresented: $showingPremiumView) {
            PremiumView()
        }
        .sheet(item: Binding(
            get: { selectedDate.map { ReadingDateDetail(date: $0) } },
            set: { _ in 
                selectedDate = nil
                selectedDateEvents = []
            }
        )) { detail in
            ReadingDateDetailView(date: detail.date, events: selectedDateEvents)
                .environmentObject(favoriteStore)
                .environmentObject(storeManager)
        }
    }
    
    // MARK: - Premium Locked Content
    
    private var premiumLockedContent: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "lock.fill")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)
            
            Text("Reading History is a Premium Feature")
                .font(.title2.bold())
                .multilineTextAlignment(.center)
            
            Text("Track all your daily readings with a beautiful calendar view. See when you read and build your streak!")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: { showingPremiumView = true }) {
                Label("Unlock Premium", systemImage: "crown.fill")
                    .font(.headline)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .background(theme.accent)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            
            Spacer()
        }
        .padding()
    }
    
    // MARK: - Reading History Content
    
    private var readingHistoryContent: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Month/Year Header
                Text(monthYearText)
                    .font(.title2.weight(.semibold))
                    .padding(.top)
                
                // Weekday Labels
                HStack(spacing: 0) {
                    ForEach(weekdayLabels, id: \.self) { label in
                        Text(label)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal)
                
                // Calendar Grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 7), spacing: 8) {
                    ForEach(Array(monthDays.enumerated()), id: \.offset) { index, date in
                        if let date = date {
                            CalendarDayCell(
                                date: date,
                                hasReading: hasReading(for: date),
                                isToday: calendar.isDateInToday(date)
                            )
                            .onTapGesture {
                                if hasReading(for: date) {
                                    selectedDateEvents = events(for: date)
                                    selectedDate = date
                                }
                            }
                        } else {
                            Color.clear
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
                .padding(.horizontal)
                
                if history.events.isEmpty {
                    ContentUnavailableView(
                        "No Reading History",
                        systemImage: "book.closed",
                        description: Text("Your reading history will appear here once you start reading passages.")
                    )
                    .padding(.top, 40)
                }
            }
            .padding(.vertical)
        }
    }
}

private struct CalendarDayCell: View {
    let date: Date
    let hasReading: Bool
    let isToday: Bool
    
    private let calendar = Calendar.current
    
    private var dayNumber: Int {
        calendar.component(.day, from: date)
    }
    
    var body: some View {
        ZStack {
            if hasReading {
                Circle()
                    .fill(Color.accentColor)
                    .aspectRatio(1, contentMode: .fit)
            } else {
                Circle()
                    .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                    .aspectRatio(1, contentMode: .fit)
            }
            
            Text("\(dayNumber)")
                .font(.system(size: 14, weight: isToday ? .semibold : .regular))
                .foregroundStyle(hasReading ? .white : (isToday ? .primary : .secondary))
        }
        .frame(maxWidth: .infinity)
    }
}

private struct ReadingDateDetail: Identifiable {
    var id: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    let date: Date
}

struct ReadingDateDetailView: View {
    let date: Date
    let events: [ReadingEvent]
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var favoriteStore: FavoriteStore
    @AppStorage("readingMode") private var readingMode = "default"
    
    private let calendar = Calendar.current
    private let dailyVerseProvider = DailyVerseProvider()
    
    private var theme: ReadingTheme {
        ReadingTheme.from(rawValue: readingMode)
    }
    
    private var dateText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: date)
    }
    
    private var dailyVerses: [Verse] {
        dailyVerseProvider.versesForDate(date)
    }
    
    private var firstReadTime: Date? {
        events.sorted { $0.date < $1.date }.first?.date
    }
    
    var body: some View {
        NavigationStack {
            List {
                if !dailyVerses.isEmpty {
                    Section {
                        ForEach(Array(dailyVerses.enumerated()), id: \.element.id) { index, verse in
                            VStack(alignment: .leading, spacing: 12) {
                                if dailyVerses.count > 1 {
                                    Text("Verse \(index + 1)")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .textCase(.uppercase)
                                }
                                
                                Text(verse.text)
                                    .font(.title3.weight(.semibold))
                                
                                Text(verse.reference)
                                    .font(.headline)
                                    .foregroundStyle(.secondary)
                                
                                // Favorite button
                                HStack {
                                    Button(action: { favoriteStore.toggleFavorite(verse) }) {
                                        HStack(spacing: 4) {
                                            Image(systemName: favoriteStore.isFavorite(verse) ? "star.fill" : "star")
                                                .font(.caption)
                                            Text(favoriteStore.isFavorite(verse) ? "Favorited" : "Add to Favorites")
                                                .font(.caption)
                                        }
                                        .foregroundStyle(favoriteStore.isFavorite(verse) ? .yellow : .secondary)
                                        .opacity(favoriteStore.isFavorite(verse) ? 1.0 : 0.6)
                                    }
                                    
                                    if index == 0, let firstRead = firstReadTime {
                                        Spacer()
                                        HStack {
                                            Image(systemName: "clock")
                                            Text("First read: \(firstRead.formatted(date: .omitted, time: .shortened))")
                                        }
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    } header: {
                        Text(dateText)
                    }
                } else {
                    Section {
                        Text("No verse available for this date.")
                            .foregroundStyle(.secondary)
                    } header: {
                        Text(dateText)
                    }
                }
            }
            .navigationTitle("Reading Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(theme.background)
        }
        .background(theme.background.ignoresSafeArea())
        .preferredColorScheme(theme.colorScheme)
        .tint(theme.accent)
    }
}
