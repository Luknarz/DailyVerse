# DailyVerse App Store Submission Guide

## ✅ Pre-Submission Checklist

### Current App Status
- ✅ **Bundle ID**: `com.dailyverse.app` (already configured)
- ✅ **Version**: 1.0 (CFBundleShortVersionString)
- ✅ **Build Number**: 1 (CURRENT_PROJECT_VERSION)
- ✅ **Deployment Target**: iOS 17.0 (⚠️ Consider lowering to iOS 16.0 or 15.0 for broader compatibility)
- ✅ **App Icon**: 1024x1024 marketing icon present
- ✅ **Info.plist**: Fixed (removed incorrect NSCalendarsUsageDescription)
- ✅ **Permissions**: Only uses UserNotifications (no special permissions required in Info.plist)
- ✅ **Privacy**: Fully offline app, no data collection, no network access

### Issues Fixed
- ✅ Removed incorrect `NSCalendarsUsageDescription` from Info.plist (app doesn't use calendar access)

### ⚠️ Items to Consider
1. **Deployment Target**: Currently iOS 17.0. Consider lowering to iOS 16.0 or 15.0 to reach more users
2. **App Icon**: Verify `Icon-marketing.png` is exactly 1024x1024px with no transparency
3. **Screenshots**: Need to create screenshots for required device sizes
4. **Privacy Policy**: Since app is fully offline and doesn't collect data, you may not need one, but Apple sometimes requires it anyway

---

## 📋 Complete Step-by-Step Submission Process

### STEP 1: Final App Preparation

#### 1.1 Test on Real Devices
- [ ] Test on at least 2-3 different iPhone models (iPhone 14, 15, etc.)
- [ ] Test on different iOS versions (if supporting multiple)
- [ ] Verify all features work: verses load, streak tracking, notifications, sharing, favorites
- [ ] Test notification scheduling and delivery
- [ ] Verify app works offline (airplane mode)
- [ ] Test sharing functionality
- [ ] Check for any crashes or bugs

#### 1.2 Verify App Configuration in Xcode
1. Open your project in Xcode
2. Select the **DailyVerse** target
3. Go to **General** tab:
   - ✅ **Display Name**: "DailyVerse" (or your preferred name)
   - ✅ **Bundle Identifier**: `com.dailyverse.app`
   - ✅ **Version**: `1.0`
   - ✅ **Build**: `1` (increment this for each submission)
   - ✅ **Deployment Target**: Currently `17.0` (consider changing to `16.0`)

4. Go to **Signing & Capabilities**:
   - ✅ **Team**: Select your Apple Developer account
   - ✅ **Automatically manage signing**: Checked
   - ✅ **Bundle Identifier**: Should match `com.dailyverse.app`
   - ✅ **Capabilities**: Should only have "Push Notifications" if needed (your app uses local notifications, so this may not be required)

5. Go to **Info** tab:
   - ✅ Verify `Info.plist` is correct (we just fixed it)

#### 1.3 Clean Build
1. In Xcode: **Product** → **Clean Build Folder** (Shift+Cmd+K)
2. Close and reopen Xcode
3. Build again to ensure everything compiles

---

### STEP 2: Prepare App Store Assets

#### 2.1 App Icon (1024x1024)
- [ ] Verify `Icon-marketing.png` in `Assets.xcassets/AppIcon.appiconset/` is exactly 1024x1024px
- [ ] Must be PNG format
- [ ] No transparency (alpha channel)
- [ ] No rounded corners (Apple adds them automatically)
- [ ] Should look good at small sizes

#### 2.2 Screenshots (Required)
You need screenshots for different iPhone sizes. Minimum required:

**For iPhone 15 Pro Max (6.7" display):**
- [ ] 1290 x 2796 pixels (portrait)
- [ ] At least 3-5 screenshots showing:
  1. Home screen with verse
  2. Reading history calendar
  3. Favorites view
  4. Settings screen
  5. Share card example

**For iPhone 14 Pro Max (6.5" display) - Optional but recommended:**
- [ ] 1284 x 2778 pixels (portrait)

**How to Create Screenshots:**
1. Run your app in the iOS Simulator
2. Select device: **iPhone 15 Pro Max** (or iPhone 14 Pro Max)
3. Navigate to each screen
4. Press **Cmd+S** to save screenshot, or use **Device** → **Screenshots**
5. Screenshots are saved to Desktop
6. Edit if needed (remove status bar if desired, but not required)

**Screenshot Tips:**
- Show the app's best features
- Use real content (not placeholder text)
- Make sure text is readable
- Show different states (e.g., with/without favorites)
- Keep it simple and clean

#### 2.3 App Preview Video (Optional but Recommended)
- [ ] Create a 15-30 second video showing:
  - Opening the app
  - Viewing today's verse
  - Marking as read
  - Viewing history
  - Sharing a verse
- [ ] Record using QuickTime Player or screen recording
- [ ] Export as MP4
- [ ] Max file size: 500MB
- [ ] Recommended resolution: 1080p

#### 2.4 App Description & Metadata
Prepare the following text:

**App Name**: "DailyVerse" (must be unique, max 30 characters)

**Subtitle** (optional, max 30 characters): e.g., "Daily Bible Reading"

**Description** (max 4000 characters):
```
DailyVerse helps you build a daily Bible reading habit with short, meaningful verses delivered each day.

KEY FEATURES:
• Daily Verses: Receive a new verse each day from a curated collection
• Streak Tracking: Build consistency with visual streak counters
• Reading History: Track your progress with a beautiful calendar view
• Favorites: Save verses that inspire you
• Shareable Cards: Share beautiful verse images with friends
• Offline First: All content works without internet connection
• Customizable Notifications: Set daily reminders at your preferred time

PRIVACY:
DailyVerse is completely offline. All data is stored locally on your device. We don't collect, share, or sell any personal information.

Start your daily habit today and let God's Word guide your journey.
```

**Keywords** (max 100 characters, comma-separated):
```
bible,verse,daily,devotional,scripture,reading,christian,faith,spiritual,habit
```

**Promotional Text** (optional, max 170 characters, can be updated without resubmission):
```
Build a daily Bible reading habit with DailyVerse. New verses each day, streak tracking, and beautiful shareable cards.
```

**Support URL** (required):
- Create a simple webpage or use a placeholder
- Example: `https://yourwebsite.com/support` or `https://github.com/yourusername/dailyverse`
- Must be a valid URL (can be a simple landing page)

**Marketing URL** (optional):
- Your website or app landing page

**Privacy Policy URL** (may be required):
- Since your app is fully offline, you may not need this, but Apple sometimes requires it
- Create a simple privacy policy stating:
  - App is fully offline
  - No data collection
  - All data stored locally
  - No third-party sharing
- Host it on your website or use a free service

---

### STEP 3: Configure App in Xcode

#### 3.1 Set Build Configuration
1. In Xcode, select **Product** → **Scheme** → **Edit Scheme**
2. Select **Archive** in the left sidebar
3. Set **Build Configuration** to **Release**
4. Click **Close**

#### 3.2 Increment Build Number
1. Select the **DailyVerse** target
2. Go to **General** tab
3. Increment **Build** number (e.g., from `1` to `2`)
4. Or in **Info.plist**, change `CFBundleVersion` from `1` to `2`

**Important**: Each time you submit, increment the build number. Version can stay `1.0` for bug fixes, but build must always increase.

#### 3.3 Verify Code Signing
1. Go to **Signing & Capabilities**
2. Ensure **Team** is selected (your Apple Developer account)
3. **Automatically manage signing** should be checked
4. Xcode should show "Provisioning profile created successfully"

---

### STEP 4: Archive Your App

#### 4.1 Select Build Target
1. In Xcode, at the top toolbar, click the device selector
2. Select **Any iOS Device** (NOT a simulator - this is critical!)
   - If "Any iOS Device" doesn't appear, connect a physical iPhone via USB

#### 4.2 Create Archive
1. Go to **Product** → **Archive**
2. Wait for the build to complete (this may take several minutes)
3. The **Organizer** window will open automatically when done
4. If Organizer doesn't open: **Window** → **Organizer**

#### 4.3 Verify Archive
In the Organizer:
- [ ] You should see your archive listed with today's date
- [ ] Version should show `1.0`
- [ ] Build should show your current build number
- [ ] Status should be ready for distribution

---

### STEP 5: Create App in App Store Connect

#### 5.1 Access App Store Connect
1. Go to [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
2. Sign in with your Apple Developer account
3. Click **My Apps** (or the Apps icon)

#### 5.2 Create New App
1. Click the **+** button (top left)
2. Select **New App**
3. Fill in the form:

   **Platform**: iOS
   
   **Name**: "DailyVerse" (must be unique across entire App Store)
   - If taken, try: "DailyVerse - Bible Reading", "DailyVerse Daily", etc.
   
   **Primary Language**: English (or your preferred language)
   
   **Bundle ID**: Select `com.dailyverse.app` from dropdown
   - If it doesn't appear, you need to create it in Apple Developer portal first
   
   **SKU**: `dailyverse-001` (internal tracking ID, can be anything unique)
   
   **User Access**: Full Access (unless you're part of an organization)

4. Click **Create**

#### 5.3 App Information
1. In your new app, go to **App Information** tab
2. Fill in:

   **Category**: 
   - Primary: **Lifestyle** or **Reference**
   - Secondary: (optional)
   
   **Content Rights**: 
   - Check "I have the rights to use all content in this app"
   
   **Age Rating**: 
   - Click **Edit** and complete the questionnaire
   - For DailyVerse: Should be **4+** (no objectionable content)
   - Questions to answer:
     - Unrestricted Web Access: No
     - User Generated Content: No
     - Gambling/Contests: No
     - Horror/Fear Themes: No
     - Profanity/Crude Humor: No
     - Sexual Content/Nudity: No
     - Violence: No
     - Alcohol/Tobacco/Drugs: No
     - Mature/Suggestive Themes: No
     - Medical/Treatment Information: No
     - Legal/Gambling Advice: No

---

### STEP 6: Fill Out Version Information

#### 6.1 Version Details
1. Click **1.0 Prepare for Submission** (or the version number)
2. Fill in **Version Information**:

   **What's New in This Version** (required for first version, max 4000 chars):
   ```
   Welcome to DailyVerse! The first version includes:
   
   • Daily Bible verses delivered each day
   • Streak tracking to build consistency
   • Beautiful reading history calendar
   • Save favorite verses
   • Share verse cards with friends
   • Customizable daily notifications
   • Fully offline - works without internet
   ```

   **Description**: Paste your app description (from Step 2.4)
   
   **Keywords**: Paste your keywords (from Step 2.4)
   
   **Support URL**: Enter your support URL
   
   **Marketing URL**: (optional) Enter if you have one
   
   **Promotional Text**: (optional) Paste from Step 2.4

#### 6.2 Upload Screenshots
1. Scroll to **App Preview and Screenshots**
2. For **iPhone 6.7" Display (iPhone 15 Pro Max)**:
   - [ ] Click **+** to add screenshots
   - [ ] Upload at least 3 screenshots (up to 10)
   - [ ] Drag to reorder (first screenshot is most important)
3. For other sizes (optional but recommended):
   - [ ] Upload for iPhone 6.5" if you have them

#### 6.3 App Preview (Optional)
- [ ] Upload your app preview video if you created one

#### 6.4 App Icon
- [ ] The 1024x1024 icon from your Xcode project should auto-populate
- [ ] If not, upload it manually

---

### STEP 7: Upload Your Build

#### 7.1 Distribute from Xcode
1. Go back to Xcode **Organizer** (Window → Organizer)
2. Select your archive
3. Click **Distribute App**
4. Select **App Store Connect**
5. Click **Next**
6. Select **Upload**
7. Click **Next**
8. Review options:
   - ✅ **Include bitcode**: Usually checked (leave as default)
   - ✅ **Upload symbols**: Checked (helps with crash reports)
9. Click **Next**
10. Select your distribution certificate and provisioning profile (Xcode should auto-select)
11. Click **Next**
12. Review summary
13. Click **Upload**
14. Wait for validation and upload (10-30 minutes depending on size)

#### 7.2 Verify Upload
- [ ] Xcode will show "Upload Successful" when done
- [ ] Note: Processing in App Store Connect takes 10-15 minutes

---

### STEP 8: Select Build in App Store Connect

#### 8.1 Wait for Processing
1. Go back to App Store Connect
2. In your app's version page, scroll to **Build** section
3. Wait until you see your build appear (may take 10-15 minutes)
4. Status will show "Processing" then change to ready

#### 8.2 Select Build
1. Click the **+** button next to **Build**
2. Select your uploaded build
3. Click **Done**

---

### STEP 9: Complete Compliance Information

#### 9.1 Export Compliance
1. Scroll to **App Privacy** section
2. Click **Edit** next to **App Privacy**
3. Answer the questions:

   **Does your app collect data?**
   - Select **No** (your app is fully offline, stores data locally only)
   
   **Does your app use encryption?**
   - Select **No** (unless you're using HTTPS, which you're not)
   - If unsure, select "Yes, but exempt" (most apps are exempt)
   
   **Does your app use the Advertising Identifier (IDFA)?**
   - Select **No** (your app doesn't show ads)

4. Click **Save**

#### 9.2 Advertising Identifier
- [ ] Should already be answered in App Privacy section
- [ ] If asked separately, answer **No**

---

### STEP 10: Submit for Review

#### 10.1 Final Checks
Before submitting, verify:
- [ ] All required fields are filled (green checkmarks)
- [ ] Screenshots uploaded
- [ ] Build selected
- [ ] Description and metadata complete
- [ ] Age rating completed
- [ ] App Privacy information filled

#### 10.2 Submit
1. Scroll to top of version page
2. Click **Add for Review** (or **Submit for Review**)
3. You may be asked:
   - **Demo Account**: Select "No demo account required" (your app doesn't require login)
   - **Contact Information**: Your email (should be pre-filled)
   - **Notes for Review**: (Optional) Add any special instructions:
     ```
     This app is fully offline and doesn't require internet connection.
     All features work without login or account creation.
     Notifications are optional and can be enabled in Settings.
     ```
4. Click **Submit**

#### 10.3 Confirmation
- [ ] Status changes to "Waiting for Review"
- [ ] You'll receive an email confirmation
- [ ] App appears in **App Store Connect** with "Waiting for Review" status

---

### STEP 11: Wait for Review

#### 11.1 Review Timeline
- **Typical**: 24-48 hours
- **Can take**: Up to 7 days (rare)
- **Expedited review**: Available for critical bug fixes (limited uses per year)

#### 11.2 Review Status Updates
You'll receive emails for:
- **In Review**: Apple is actively reviewing
- **Pending Developer Release**: Approved, waiting for your release date
- **Ready for Sale**: Live in App Store
- **Rejected**: Issues found, needs fixes

#### 11.3 If Rejected
1. Read the rejection reason carefully in App Store Connect
2. Fix the issues
3. Increment build number
4. Create new archive and upload
5. Resubmit

Common rejection reasons for your app type:
- Missing or unclear privacy policy
- App crashes during review
- Misleading screenshots
- Incomplete app information

---

### STEP 12: After Approval

#### 12.1 App Goes Live
- App appears in App Store within 24 hours of approval
- Users can download immediately (or on your specified release date)

#### 12.2 Monitor
- Check **App Store Connect** for:
  - Download statistics
  - User reviews
  - Ratings
  - Crash reports (if any)

#### 12.3 Respond to Reviews
- [ ] Monitor user reviews
- [ ] Respond to feedback professionally
- [ ] Address common issues in future updates

---

## 📝 Additional Notes

### Privacy Policy
Even though your app is fully offline, Apple may require a privacy policy URL. Create a simple one:

**Template:**
```
Privacy Policy for DailyVerse

Last Updated: [Date]

DailyVerse is committed to your privacy.

Data Collection:
DailyVerse does not collect, store, or transmit any personal information. The app operates entirely offline.

Local Storage:
All data (reading history, favorites, streaks) is stored locally on your device using iOS UserDefaults. This data never leaves your device.

Third-Party Services:
DailyVerse does not use any third-party analytics, advertising, or tracking services.

Contact:
If you have questions about this privacy policy, contact us at [your email].

Changes:
We may update this policy. Changes will be posted here.
```

Host this on a simple webpage (GitHub Pages, your website, etc.)

### Deployment Target Consideration
Your app currently targets iOS 17.0. Consider:
- **iOS 16.0**: Reaches ~95% of active devices
- **iOS 15.0**: Reaches ~98% of active devices
- **iOS 17.0**: Reaches ~70-80% of active devices (as of early 2024)

To change: In Xcode → Target → General → Deployment → iOS Deployment Target

### Version vs Build Number
- **Version** (CFBundleShortVersionString): User-facing version (1.0, 1.1, 2.0)
- **Build** (CFBundleVersion): Internal build number (1, 2, 3, ...)
- **Rule**: Build number must always increase, even for same version

### Testing Checklist
Before submitting, test:
- [ ] App launches without crashes
- [ ] Verses load correctly
- [ ] Streak tracking works
- [ ] Notifications schedule and fire
- [ ] Sharing works (images and text)
- [ ] Favorites save and persist
- [ ] Reading history displays correctly
- [ ] Settings save preferences
- [ ] App works in airplane mode (offline)
- [ ] No placeholder text visible
- [ ] All buttons are functional
- [ ] Navigation works smoothly

---

## ✅ Final Pre-Submission Checklist

- [ ] App tested on real devices
- [ ] All bugs fixed
- [ ] Build number incremented
- [ ] App icon 1024x1024 ready
- [ ] Screenshots created (at least 3 for 6.7" display)
- [ ] App description written
- [ ] Keywords prepared
- [ ] Support URL ready
- [ ] Privacy policy URL ready (if required)
- [ ] App archived successfully
- [ ] Build uploaded to App Store Connect
- [ ] Build selected in App Store Connect
- [ ] All metadata filled in
- [ ] Age rating completed
- [ ] App Privacy information completed
- [ ] Ready to submit!

---

## 🎉 Good Luck!

Your app looks solid and should have a smooth submission process. The offline-first approach and lack of data collection makes privacy compliance straightforward.

If you encounter any issues during submission, refer back to this guide or check Apple's official documentation at [developer.apple.com/app-store/review](https://developer.apple.com/app-store/review/).
