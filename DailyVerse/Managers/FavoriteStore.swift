import Foundation
import SwiftUI

@MainActor
final class FavoriteStore: ObservableObject {
    @Published private(set) var favoriteIDs: Set<Int> = []
    
    private let storageKey = "favoriteVerseIDs"
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        load()
    }
    
    func toggleFavorite(_ verse: Verse) {
        if favoriteIDs.contains(verse.id) {
            favoriteIDs.remove(verse.id)
        } else {
            favoriteIDs.insert(verse.id)
        }
        save()
    }
    
    func isFavorite(_ verse: Verse) -> Bool {
        return favoriteIDs.contains(verse.id)
    }
    
    func isFavorite(id: Int) -> Bool {
        return favoriteIDs.contains(id)
    }
    
    // MARK: - Private
    
    private func save() {
        let array = Array(favoriteIDs)
        defaults.set(array, forKey: storageKey)
    }
    
    private func load() {
        if let array = defaults.array(forKey: storageKey) as? [Int] {
            favoriteIDs = Set(array)
        }
    }
}

