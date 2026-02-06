import Foundation
import SwiftUI

@MainActor
final class FavoriteStore: ObservableObject {
    @Published private(set) var favoriteIDs: Set<Int> = []
    
    private let storageKey = "favoriteVerseIDs"
    private let defaults: UserDefaults
    
    /// Maximum favorites for free users
    static let freeTierLimit = 3
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        load()
    }
    
    /// Attempts to toggle favorite. Returns true if successful, false if limit reached.
    @discardableResult
    func toggleFavorite(_ verse: Verse, isPremium: Bool = false) -> Bool {
        if favoriteIDs.contains(verse.id) {
            // Always allow removing
            favoriteIDs.remove(verse.id)
            save()
            return true
        } else {
            // Check limit for free users
            if !isPremium && favoriteIDs.count >= Self.freeTierLimit {
                return false
            }
            favoriteIDs.insert(verse.id)
            save()
            return true
        }
    }
    
    func isFavorite(_ verse: Verse) -> Bool {
        return favoriteIDs.contains(verse.id)
    }
    
    func isFavorite(id: Int) -> Bool {
        return favoriteIDs.contains(id)
    }
    
    /// Check if user can add more favorites
    func canAddMoreFavorites(isPremium: Bool) -> Bool {
        if isPremium { return true }
        return favoriteIDs.count < Self.freeTierLimit
    }
    
    /// Number of favorites remaining for free users
    func remainingFavorites(isPremium: Bool) -> Int {
        if isPremium { return Int.max }
        return max(0, Self.freeTierLimit - favoriteIDs.count)
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

