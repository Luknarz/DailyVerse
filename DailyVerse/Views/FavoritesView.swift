import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favoriteStore: FavoriteStore
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
                                    
                                    Button(action: { favoriteStore.toggleFavorite(verse) }) {
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
}

