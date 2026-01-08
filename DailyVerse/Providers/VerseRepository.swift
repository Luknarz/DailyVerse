import Foundation

final class VerseRepository {
    private enum Keys {
        static let shuffledSequence = "verseRepository.shuffledSequence"
        static let currentIndex = "verseRepository.currentIndex"
    }
    
    private let bundle: Bundle
    private let defaults: UserDefaults
    private var verses: [Verse] = []
    private var shuffledSequence: [Int] = []
    private var currentIndex: Int = 0
    
    init(bundle: Bundle = .main, defaults: UserDefaults = .standard) {
        self.bundle = bundle
        self.defaults = defaults
        loadVerses()
        initializeShuffledSequence()
    }
    
    func verse(for index: Int) -> Verse? {
        guard index >= 0, index < shuffledSequence.count else { return nil }
        let verseId = shuffledSequence[index]
        return verses.first { $0.id == verseId }
    }
    
    func verse(byId id: Int) -> Verse? {
        return verses.first { $0.id == id }
    }
    
    func nextVerseIndex() -> Int {
        let index = currentIndex
        currentIndex += 1
        if currentIndex >= shuffledSequence.count {
            currentIndex = 0 // Reset when exhausted
        }
        saveCurrentIndex()
        return index
    }
    
    func reset() {
        shuffledSequence = []
        currentIndex = 0
        defaults.removeObject(forKey: Keys.shuffledSequence)
        defaults.removeObject(forKey: Keys.currentIndex)
        initializeShuffledSequence()
    }
    
    // MARK: - Private
    
    private func loadVerses() {
        guard let url = bundle.url(forResource: "verses", withExtension: "json") else {
            assertionFailure("verses.json missing from bundle")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            verses = try decoder.decode([Verse].self, from: data)
        } catch {
            assertionFailure("Failed to decode verses.json: \(error)")
            verses = []
        }
    }
    
    private func initializeShuffledSequence() {
        if let stored = defaults.array(forKey: Keys.shuffledSequence) as? [Int], !stored.isEmpty {
            shuffledSequence = stored
            currentIndex = defaults.integer(forKey: Keys.currentIndex)
        } else {
            // Create shuffled sequence using a seed based on app installation
            let seed = getOrCreateSeed()
            var sequence = verses.map { $0.id }
            var rng = SeededRandomNumberGenerator(seed: seed)
            sequence.shuffle(using: &rng)
            shuffledSequence = sequence
            currentIndex = 0
            saveShuffledSequence()
            saveCurrentIndex()
        }
    }
    
    private func getOrCreateSeed() -> UInt64 {
        let key = "verseRepository.seed"
        if let stored = defaults.object(forKey: key) as? UInt64 {
            return stored
        } else {
            let seed = UInt64.random(in: 0...UInt64.max)
            defaults.set(seed, forKey: key)
            return seed
        }
    }
    
    private func saveShuffledSequence() {
        defaults.set(shuffledSequence, forKey: Keys.shuffledSequence)
    }
    
    private func saveCurrentIndex() {
        defaults.set(currentIndex, forKey: Keys.currentIndex)
    }
}

// MARK: - Seeded Random Number Generator

struct SeededRandomNumberGenerator: RandomNumberGenerator {
    private var state: UInt64
    
    init(seed: UInt64) {
        self.state = seed
    }
    
    mutating func next() -> UInt64 {
        state = state &* 1103515245 &+ 12345
        return state
    }
}

