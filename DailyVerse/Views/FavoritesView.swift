import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favoriteStore: FavoriteStore
    @EnvironmentObject private var storeManager: StoreManager
    private let verseRepository = VerseRepository()
    @AppStorage("readingMode") private var readingMode = "default"

    private var theme: ReadingTheme {
        ReadingTheme.from(rawValue: readingMode)
    }
    
    private var favoriteVerses: [Verse] {
        favoriteStore.favoriteIDs.compactMap { id in
            verseRepository.verse(byId: id)
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Free tier limit banner
                    if !storeManager.isPremium {
                        freeTierBanner
                    }
                    
                    if favoriteVerses.isEmpty {
                        ContentUnavailableView(
                            "No Favorites",
                            systemImage: "star",
                            description: Text("Verses you favorite will appear here.")
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ForEach(favoriteVerses, id: \.id) { verse in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(verse.text)
                                    .font(.title2.weight(.semibold))
                                    .foregroundStyle(.primary)
                                
                                HStack {
                                    Text(verse.reference)
                                        .font(.headline)
                                        .foregroundStyle(.secondary)
                                    
                                    Spacer()
                                    
                                    Button(action: { favoriteStore.toggleFavorite(verse, isPremium: storeManager.isPremium) }) {
                                        Image(systemName: "star.fill")
                                            .font(.caption)
                                            .foregroundStyle(.yellow)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                            
                            if verse.id != favoriteVerses.last?.id {
                                Divider()
                                    .opacity(0.3)
                                    .padding(.vertical, 12)
                            }
                        }
                    }
                }
                .padding(24)
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.large)
            .background(theme.background)
        }
        .background(theme.background.ignoresSafeArea())
        .preferredColorScheme(theme.colorScheme)
        .tint(theme.accent)
    }
    
    // MARK: - Free Tier Banner
    
    @State private var showingPremiumView = false
    
    private var freeTierBanner: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("\(favoriteStore.remainingFavorites(isPremium: false)) of \(FavoriteStore.freeTierLimit) favorites remaining")
                    .font(.subheadline.bold())
                Text("Upgrade for unlimited favorites")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Button(action: { showingPremiumView = true }) {
                Image(systemName: "crown.fill")
                    .foregroundStyle(.yellow)
            }
        }
        .padding()
        .background(theme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .sheet(isPresented: $showingPremiumView) {
            PremiumView()
        }
    }
}

