import SwiftUI
import UIKit

struct HomeView: View {
    @ObservedObject var viewModel: DailyPassageViewModel
    @EnvironmentObject private var notificationManager: NotificationManager
    @EnvironmentObject private var readingHistory: ReadingHistoryStore
    @EnvironmentObject private var favoriteStore: FavoriteStore
    @EnvironmentObject private var storeManager: StoreManager
    @State private var showingAppMenu = false
    @State private var showingVerseSelection = false
    @State private var showingPremiumView = false
    @State private var showingFavoriteLimitAlert = false
    @AppStorage("readingMode") private var readingMode = "default"
    @AppStorage("extraVersesToday") private var extraVersesToday = 0
    @AppStorage("lastExtraVerseDate") private var lastExtraVerseDate = ""

    private var theme: ReadingTheme {
        ReadingTheme.from(rawValue: readingMode)
    }

    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        passageSection(proxy: proxy)
                        progressSection
                        actionButtons(proxy: proxy)
                    }
                    .padding(24)
                }
                .animation(.easeInOut, value: viewModel.todaysVerses.count)
                .background(theme.background)
            }
            .navigationTitle("Daily Verse Reading")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showingAppMenu = true }) {
                        Image(systemName: "ellipsis.circle")
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    HStack {
                        NavigationLink(destination: FavoritesView()
                            .environmentObject(favoriteStore)) {
                            Image(systemName: "star.fill")
                        }
                        NavigationLink(destination: ReadingHistoryView()
                            .environmentObject(favoriteStore)) {
                            Image(systemName: "book.fill")
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAppMenu) {
                AppActionsMenuView(viewModel: viewModel)
                    .environmentObject(notificationManager)
            }
            .sheet(isPresented: $showingVerseSelection) {
                VerseSelectionShareView(verses: viewModel.todaysVerses, viewModel: viewModel)
            }
            .sheet(isPresented: $showingPremiumView) {
                PremiumView()
            }
            .alert("Favorite Limit Reached", isPresented: $showingFavoriteLimitAlert) {
                Button("Upgrade to Premium") {
                    showingPremiumView = true
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Free users can save up to \(FavoriteStore.freeTierLimit) favorites. Upgrade to Premium for unlimited favorites!")
            }
        }
        .background(theme.background.ignoresSafeArea())
        .preferredColorScheme(theme.colorScheme)
        .tint(theme.accent)
        .onAppear {
            viewModel.loadToday()
            resetExtraVersesIfNewDay()
        }
    }
    
    /// Reset extra verse counter if it's a new day
    private func resetExtraVersesIfNewDay() {
        let today = ISO8601DateFormatter().string(from: Date()).prefix(10)
        if lastExtraVerseDate != String(today) {
            extraVersesToday = 0
            lastExtraVerseDate = String(today)
        }
    }
    
    /// Check if user can read another verse
    private var canReadAnotherVerse: Bool {
        if storeManager.isPremium { return true }
        return extraVersesToday < 1 // Free users get 1 extra verse per day
    }

    private func passageSection(proxy: ScrollViewProxy) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Today's Passage")
                .font(.caption)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
            
            if viewModel.todaysVerses.isEmpty {
                Text("Unable to load today's verse.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(viewModel.todaysVerses, id: \.id) { verse in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(verse.text)
                            .font(.title2.weight(.semibold))
                            .foregroundStyle(.primary)
                        Text(verse.reference)
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                        // Per-verse action buttons
                        HStack(spacing: 16) {
                            Button(action: { handleShareVerse(verse) }) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .opacity(0.6)
                            }
                            
                            Button(action: { handleCopyVerse(verse) }) {
                                Image(systemName: "doc.on.doc")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .opacity(0.6)
                            }
                            
                            Button(action: { handleToggleFavorite(verse) }) {
                                Image(systemName: favoriteStore.isFavorite(verse) ? "star.fill" : "star")
                                    .font(.caption)
                                    .foregroundStyle(favoriteStore.isFavorite(verse) ? .yellow : .secondary)
                                    .opacity(favoriteStore.isFavorite(verse) ? 1.0 : 0.6)
                            }
                        }
                        .padding(.top, 4)
                    }
                    .id(verse.id)
                    .padding(.vertical, 4)
                    
                    if verse.id != viewModel.todaysVerses.last?.id {
                        Divider()
                            .opacity(0.3)
                            .padding(.vertical, 12)
                    }
                }
            }
        }
    }

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your Progress")
                .font(.caption)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)

            Label("🔥 \(viewModel.streakCount)-day streak!", systemImage: "flame.fill")
                .font(.title2.weight(.bold))

            Text("Longest: \(viewModel.longestStreak) day\(viewModel.longestStreak == 1 ? "" : "s")")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(theme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func actionButtons(proxy: ScrollViewProxy) -> some View {
        VStack(spacing: 12) {
            Button(action: handleMarkAsRead) {
                Label(viewModel.hasReadToday ? "Already Read" : "Mark as Read",
                      systemImage: "checkmark.circle.fill")
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.hasReadToday)

            if viewModel.todaysVerses.count == 1 {
                Button(action: handleShare) {
                    Label("Share Verse", systemImage: "square.and.arrow.up")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            } else {
                Menu {
                    Button(action: { handleShareAllVerses() }) {
                        Label("Share All Verses", systemImage: "square.and.arrow.up.on.square")
                    }
                    Button(action: { handleShareFirstVerse() }) {
                        Label("Share First Verse", systemImage: "square.and.arrow.up")
                    }
                    Button(action: { showingVerseSelection = true }) {
                        Label("Select Verses to Share", systemImage: "checkmark.square")
                    }
                } label: {
                    Label("Share Verses", systemImage: "square.and.arrow.up")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }
            
            Button(action: { handleReadAnotherVerse(proxy: proxy) }) {
                HStack {
                    Label("Read another verse", systemImage: "plus.circle")
                    if !storeManager.isPremium && !canReadAnotherVerse {
                        Image(systemName: "crown.fill")
                            .foregroundStyle(.yellow)
                            .font(.caption)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .padding(.vertical, 4)
        }
    }

    private func handleMarkAsRead() {
        viewModel.markAsRead()
        recordPassageView()
    }
    
    private func recordPassageView() {
        // Record all verses for today
        for verse in viewModel.todaysVerses {
            readingHistory.record(
                book: verse.book,
                chapter: verse.chapter,
                verses: [verse.verse]
            )
        }
    }
    
    private func handleReadAnotherVerse(proxy: ScrollViewProxy) {
        // Check if user can read another verse
        if !canReadAnotherVerse {
            showingPremiumView = true
            return
        }
        
        let previousCount = viewModel.todaysVerses.count
        viewModel.fetchAdditionalVerseForToday()
        
        // Track extra verses for free users
        if !storeManager.isPremium {
            extraVersesToday += 1
        }
        
        // Auto-scroll to the newly added verse after a brief delay to allow animation
        if let lastVerse = viewModel.todaysVerses.last, viewModel.todaysVerses.count > previousCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    proxy.scrollTo(lastVerse.id, anchor: .center)
                }
            }
        }
    }

    private func handleShare() {
        guard let verse = viewModel.todaysVerses.first else {
            return
        }
        handleShareVerse(verse)
    }
    
    private func handleShareAllVerses() {
        let text = viewModel.shareAllVersesAsText()
        let controller = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let root = window.rootViewController {
            root.present(controller, animated: true)
        }
    }
    
    private func handleShareFirstVerse() {
        guard let verse = viewModel.todaysVerses.first else {
            return
        }
        handleShareVerse(verse)
    }
    
    private func handleShareVerse(_ verse: Verse) {
        guard let image = viewModel.share(verse: verse) else {
            return
        }

        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let root = window.rootViewController {
            root.present(controller, animated: true)
        }
    }
    
    private func handleCopyVerse(_ verse: Verse) {
        viewModel.copy(verse: verse)
    }
    
    private func handleToggleFavorite(_ verse: Verse) {
        let success = favoriteStore.toggleFavorite(verse, isPremium: storeManager.isPremium)
        if !success {
            showingFavoriteLimitAlert = true
        }
    }
}
