import Foundation
import StoreKit

/// Manages in-app purchases using StoreKit 2
@MainActor
class StoreManager: ObservableObject {
    static let shared = StoreManager()
    
    // Product ID for premium unlock
    static let premiumProductID = "com.luknarz.dailyverse.premium"
    
    @Published private(set) var products: [Product] = []
    @Published private(set) var isPremium: Bool = false
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    
    private var updateListenerTask: Task<Void, Error>?
    
    init() {
        // Start listening for transactions
        updateListenerTask = listenForTransactions()
        
        // Check existing entitlements
        Task {
            await updatePurchasedProducts()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    // MARK: - Load Products
    
    func loadProducts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let products = try await Product.products(for: [Self.premiumProductID])
            self.products = products
        } catch {
            errorMessage = "Failed to load products: \(error.localizedDescription)"
            print("Failed to load products: \(error)")
        }
        
        isLoading = false
    }
    
    // MARK: - Purchase
    
    func purchase(_ product: Product) async throws -> Bool {
        isLoading = true
        errorMessage = nil
        
        defer { isLoading = false }
        
        let result = try await product.purchase()
        
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            await updatePurchasedProducts()
            await transaction.finish()
            return true
            
        case .userCancelled:
            return false
            
        case .pending:
            errorMessage = "Purchase is pending approval"
            return false
            
        @unknown default:
            return false
        }
    }
    
    /// Convenience method to purchase premium
    func purchasePremium() async -> Bool {
        guard let product = products.first(where: { $0.id == Self.premiumProductID }) else {
            // Try to load products first
            await loadProducts()
            guard let product = products.first(where: { $0.id == Self.premiumProductID }) else {
                errorMessage = "Product not available"
                return false
            }
            return (try? await purchase(product)) ?? false
        }
        
        return (try? await purchase(product)) ?? false
    }
    
    // MARK: - Restore Purchases
    
    func restorePurchases() async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await AppStore.sync()
            await updatePurchasedProducts()
        } catch {
            errorMessage = "Failed to restore purchases: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    // MARK: - Transaction Listener
    
    private func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try await self.checkVerified(result)
                    await self.updatePurchasedProducts()
                    await transaction.finish()
                } catch {
                    print("Transaction failed verification: \(error)")
                }
            }
        }
    }
    
    // MARK: - Update Purchased Products
    
    func updatePurchasedProducts() async {
        var hasPremium = false
        
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                if transaction.productID == Self.premiumProductID {
                    hasPremium = true
                }
            } catch {
                print("Failed to verify transaction: \(error)")
            }
        }
        
        self.isPremium = hasPremium
    }
    
    // MARK: - Verification
    
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
    
    // MARK: - Premium Feature Helpers
    
    /// Check if a premium feature is available
    func canAccess(_ feature: PremiumFeature) -> Bool {
        if isPremium { return true }
        
        switch feature {
        case .unlimitedFavorites:
            return false
        case .themes:
            return false
        case .readingHistory:
            return false
        case .unlimitedExtraVerses:
            return false
        }
    }
    
    /// Get the premium product for display
    var premiumProduct: Product? {
        products.first { $0.id == Self.premiumProductID }
    }
}

// MARK: - Premium Features

enum PremiumFeature {
    case unlimitedFavorites
    case themes
    case readingHistory
    case unlimitedExtraVerses
    
    var title: String {
        switch self {
        case .unlimitedFavorites:
            return "Unlimited Favorites"
        case .themes:
            return "Reading Themes"
        case .readingHistory:
            return "Reading History"
        case .unlimitedExtraVerses:
            return "Unlimited Extra Verses"
        }
    }
    
    var description: String {
        switch self {
        case .unlimitedFavorites:
            return "Save as many verses as you want"
        case .themes:
            return "Night mode and sepia themes"
        case .readingHistory:
            return "Track all your readings"
        case .unlimitedExtraVerses:
            return "Read more verses each day"
        }
    }
    
    var iconName: String {
        switch self {
        case .unlimitedFavorites:
            return "star.fill"
        case .themes:
            return "paintpalette.fill"
        case .readingHistory:
            return "book.fill"
        case .unlimitedExtraVerses:
            return "plus.circle.fill"
        }
    }
}

// MARK: - Errors

enum StoreError: Error, LocalizedError {
    case failedVerification
    case productNotFound
    
    var errorDescription: String? {
        switch self {
        case .failedVerification:
            return "Transaction verification failed"
        case .productNotFound:
            return "Product not found"
        }
    }
}
