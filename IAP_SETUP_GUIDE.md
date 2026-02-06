# In-App Purchase Setup Guide

This guide walks you through setting up the IAP in App Store Connect and Xcode.

## 1. App Store Connect Setup

### Create the In-App Purchase Product

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Select "Daily Verse Reading" app
3. Go to **Features** → **In-App Purchases**
4. Click the **+** button to create a new IAP
5. Select **Non-Consumable** (one-time purchase, lifetime access)
6. Fill in the details:
   - **Reference Name:** Premium Unlock
   - **Product ID:** `com.luknarz.dailyverse.premium`
   - **Price:** $1.99 (Tier 2) — or equivalent in other currencies
   
### Add Localizations

For each language you support, add:

**English (US):**
- Display Name: Premium Unlock
- Description: Unlock all premium features including themes, unlimited favorites, reading history, and more.

**German:**
- Display Name: Premium freischalten
- Description: Schalte alle Premium-Funktionen frei: Themes, unbegrenzte Favoriten, Leseverlauf und mehr.

### Review Information

Add a screenshot showing what the user gets (the PremiumView paywall works well for this).

### Submit for Review

The IAP needs to be reviewed alongside your app update.

---

## 2. App Store Connect - Update App Pricing

Since you're converting from paid ($1.99) to free:

1. Go to **Pricing and Availability**
2. Change price to **Free**
3. This takes effect immediately when the new version goes live

---

## 3. Xcode Setup

### Enable StoreKit Configuration for Testing

1. Open `DailyVerse.xcodeproj` in Xcode
2. Select the **DailyVerse** scheme
3. **Edit Scheme** → **Run** → **Options**
4. Under **StoreKit Configuration**, select `Products.storekit`
5. This allows testing purchases in the simulator

### Add the StoreKit Configuration to the Project

1. In Xcode, right-click on **DailyVerse/Resources**
2. **Add Files to "DailyVerse"**
3. Select `Products.storekit`
4. Make sure "Copy items if needed" is checked

---

## 4. Testing Locally

With the StoreKit configuration enabled:

1. Run the app in Simulator
2. Go to Menu → "Upgrade to Premium"
3. The paywall should show $1.99 (from the .storekit file)
4. Tap "Unlock for $1.99" — it will succeed immediately (sandbox)
5. Verify premium features unlock

### Testing Restore Purchases

1. Delete the app from Simulator
2. Re-install and run
3. Tap "Restore Purchases" on the paywall
4. Should restore your test purchase

---

## 5. Submitting the Update

### Version Number

Update the version in Xcode:
- **Version:** 1.1.0 (or 2.0.0 if you consider this a major update)
- **Build:** Increment as needed

### What's New Text

```
NEW: Free to download!
- Now free with optional Premium upgrade
- Premium unlocks: Night & Sepia themes, unlimited favorites, reading history, and more extra verses
- Existing paid users automatically have Premium (thank you for your support!)
```

### Archive & Upload

1. **Product** → **Archive**
2. Once complete, **Distribute App** → **App Store Connect**
3. Upload and wait for processing

### App Store Connect Submission

1. Add the new build to your app version
2. Update "What's New" text
3. Ensure the IAP is included in the submission
4. Submit for review

---

## 6. Handling Existing Paid Users

Important: Users who paid $1.99 for the app should get Premium for free.

The current implementation uses StoreKit 2's `Transaction.currentEntitlements` which checks the App Store receipt. Unfortunately, this doesn't automatically grant premium to users who bought the app before it was free.

### Options:

**Option A: Trust the original purchase date (Recommended)**
Add this to `StoreManager.swift`:

```swift
// Check if user originally purchased the app (before it became free)
func checkOriginalPurchase() async -> Bool {
    // App Store receipt contains original purchase info
    // Users who bought before free conversion should have premium
    if let appTransaction = try? await AppTransaction.shared {
        let verified = try? appTransaction.payloadValue
        if let transaction = verified {
            // If original purchase date is before your free conversion date
            let freeConversionDate = ISO8601DateFormatter().date(from: "2026-02-15T00:00:00Z")!
            if transaction.originalPurchaseDate < freeConversionDate {
                return true
            }
        }
    }
    return false
}
```

**Option B: Grandfather via App Store receipt (requires server)**
More complex, involves server-side receipt validation.

For now, Option A is simplest and fair to early supporters.

---

## Checklist

- [ ] Create IAP product in App Store Connect
- [ ] Add localizations (EN, DE)
- [ ] Add review screenshot
- [ ] Change app price to Free in App Store Connect
- [ ] Enable StoreKit configuration in Xcode scheme
- [ ] Test purchases in Simulator
- [ ] Test restore purchases
- [ ] Archive and upload new build
- [ ] Submit for review with IAP

---

## Product IDs Reference

| Product | ID | Type | Price |
|---------|-----|------|-------|
| Premium Unlock | `com.luknarz.dailyverse.premium` | Non-Consumable | $1.99 |

---

## Questions?

The StoreManager.swift handles all purchase logic using StoreKit 2. The PremiumView.swift is the paywall UI. Feature gating is done throughout the app checking `storeManager.isPremium`.
