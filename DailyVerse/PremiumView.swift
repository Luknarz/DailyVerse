import SwiftUI
import StoreKit

struct PremiumView: View {
    @StateObject private var storeManager = StoreManager.shared
    @Environment(\.dismiss) private var dismiss
    @AppStorage("readingMode") private var readingMode = "default"
    
    private var theme: ReadingTheme {
        ReadingTheme.from(rawValue: readingMode)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    headerSection
                    
                    // Features list
                    featuresSection
                    
                    // Price and purchase button
                    purchaseSection
                    
                    // Restore purchases
                    restoreSection
                    
                    // Terms
                    termsSection
                }
                .padding()
            }
            .background(theme.background)
            .navigationTitle("Premium")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
        .background(theme.background.ignoresSafeArea())
        .preferredColorScheme(theme.colorScheme)
        .tint(theme.accent)
        .task {
            await storeManager.loadProducts()
        }
    }
    
    // MARK: - Header
    
    private var headerSection: some View {
        VStack(spacing: 12) {
            Image(systemName: "crown.fill")
                .font(.system(size: 60))
                .foregroundStyle(.yellow)
            
            Text("Unlock Premium")
                .font(.largeTitle.bold())
            
            Text("Get the most out of your daily reading")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top)
    }
    
    // MARK: - Features
    
    private var featuresSection: some View {
        VStack(spacing: 16) {
            ForEach([PremiumFeature.themes, .unlimitedFavorites, .readingHistory, .unlimitedExtraVerses], id: \.title) { feature in
                featureRow(feature)
            }
        }
        .padding()
        .background(theme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func featureRow(_ feature: PremiumFeature) -> some View {
        HStack(spacing: 16) {
            Image(systemName: feature.iconName)
                .font(.title2)
                .foregroundStyle(theme.accent)
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(feature.title)
                    .font(.headline)
                Text(feature.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
        }
    }
    
    // MARK: - Purchase
    
    private var purchaseSection: some View {
        VStack(spacing: 12) {
            if storeManager.isLoading {
                ProgressView()
                    .padding()
            } else if let product = storeManager.premiumProduct {
                Button(action: {
                    Task {
                        let success = await storeManager.purchasePremium()
                        if success {
                            dismiss()
                        }
                    }
                }) {
                    HStack {
                        Text("Unlock for \(product.displayPrice)")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(theme.accent)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Text("One-time purchase • Lifetime access")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else if let error = storeManager.errorMessage {
                Text(error)
                    .font(.caption)
                    .foregroundStyle(.red)
                
                Button("Try Again") {
                    Task {
                        await storeManager.loadProducts()
                    }
                }
            } else {
                Text("Loading...")
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    // MARK: - Restore
    
    private var restoreSection: some View {
        Button(action: {
            Task {
                await storeManager.restorePurchases()
                if storeManager.isPremium {
                    dismiss()
                }
            }
        }) {
            Text("Restore Purchases")
                .font(.subheadline)
                .foregroundStyle(theme.accent)
        }
        .disabled(storeManager.isLoading)
    }
    
    // MARK: - Terms
    
    private var termsSection: some View {
        VStack(spacing: 8) {
            HStack(spacing: 16) {
                Link("Privacy Policy", destination: URL(string: "https://luknarz.github.io/dailyverse-support/privacy.html")!)
                Text("•")
                    .foregroundStyle(.secondary)
                Link("Terms of Use", destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(.top)
    }
}

// MARK: - Compact Paywall (for inline use)

struct CompactPaywallView: View {
    let feature: PremiumFeature
    let onUpgrade: () -> Void
    
    @AppStorage("readingMode") private var readingMode = "default"
    
    private var theme: ReadingTheme {
        ReadingTheme.from(rawValue: readingMode)
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "lock.fill")
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text("\(feature.title) is a Premium feature")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Text(feature.description)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            Button(action: onUpgrade) {
                Label("Unlock Premium", systemImage: "crown.fill")
                    .font(.subheadline.bold())
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(theme.accent)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(theme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Preview

#Preview {
    PremiumView()
}
