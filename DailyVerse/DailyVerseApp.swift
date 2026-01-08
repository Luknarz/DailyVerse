import SwiftUI

@main
struct DailyVerseApp: App {
    @StateObject private var viewModel = DailyPassageViewModel()
    @StateObject private var notificationManager = NotificationManager()
    @StateObject private var readingHistory = ReadingHistoryStore()
    @StateObject private var favoriteStore = FavoriteStore()

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: viewModel)
                .environmentObject(notificationManager)
                .environmentObject(readingHistory)
                .environmentObject(favoriteStore)
        }
    }
}
