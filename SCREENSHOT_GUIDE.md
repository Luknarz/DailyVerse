# DailyVerse Screenshot Creation Guide

## Required Screenshots

You need **at least 3 screenshots** (up to 10 recommended) for **iPhone 15 Pro Max (6.7" display)**:
- **Resolution**: 1290 x 2796 pixels (portrait)
- **Format**: PNG or JPEG
- **No status bar removal required** (Apple allows status bars)

---

## Recommended Screenshot Sequence

### Screenshot 1: Home Screen with Verse (PRIMARY - Most Important)
**What to show:**
- Today's verse displayed prominently
- Verse text and reference
- Streak indicator showing progress (e.g., "🔥 5-day streak!")
- "Mark as Read" button visible
- Clean, minimal design

**Setup:**
1. Open the app
2. Make sure you have at least one verse loaded
3. If you have a streak, great! If not, mark today as read first
4. Scroll to show the full home screen
5. Take screenshot

**Why this is important:** This is the first thing users see. It should showcase the core value proposition.

---

### Screenshot 2: Reading History Calendar
**What to show:**
- Calendar grid view
- Multiple days with filled circles (showing reading activity)
- Month/year header visible
- Clean calendar layout

**Setup:**
1. Navigate to Reading History (book icon in toolbar)
2. Make sure you have some reading history (mark a few days as read if needed)
3. Position calendar so multiple filled days are visible
4. Take screenshot

**Why this is important:** Shows the tracking/visualization feature that helps build habits.

---

### Screenshot 3: Favorites View
**What to show:**
- List of favorited verses
- At least 2-3 favorite verses displayed
- Star icons visible
- Clean list layout

**Setup:**
1. First, favorite a few verses from the home screen
2. Navigate to Favorites (star icon in toolbar)
3. Make sure you have at least 2-3 favorites showing
4. Take screenshot

**Why this is important:** Demonstrates the ability to save and revisit meaningful verses.

---

### Screenshot 4: Settings Screen
**What to show:**
- App Settings view
- Notification settings visible
- Reading mode options
- Streak reset option (at bottom)

**Setup:**
1. Open menu (three dots icon)
2. Tap "App Settings"
3. Scroll to show all sections
4. Take screenshot

**Why this is important:** Shows customization options and user control.

---

### Screenshot 5: Share Card Example (Optional but Recommended)
**What to show:**
- Share sheet open with verse card image
- Or: Show the verse selection share view
- Beautiful verse card design visible

**Setup:**
1. From home screen, tap share button on a verse
2. Wait for share sheet to appear
3. Take screenshot (showing the share card in the share sheet)
4. OR: Tap "Select Verses to Share" and show the selection interface

**Why this is important:** Highlights the sharing feature, which is a key differentiator.

---

### Screenshot 6: Multiple Verses View (Optional)
**What to show:**
- Home screen with multiple verses for the day
- "Read another verse" button visible
- Multiple verse cards stacked

**Setup:**
1. From home screen, tap "Read another verse" a few times
2. Show 2-3 verses for the day
3. Take screenshot

**Why this is important:** Shows flexibility - users can read multiple verses per day.

---

## How to Create Screenshots

### Method 1: iOS Simulator (Recommended)

1. **Open Xcode**
2. **Open your DailyVerse project**
3. **Select Simulator Device:**
   - Go to: **Product** → **Destination** → **iPhone 15 Pro Max**
   - Or: Click device selector in toolbar → **Add Additional Simulators...** → Select iPhone 15 Pro Max
4. **Run the app:**
   - Press **Cmd + R** or click Run button
   - Wait for app to launch in simulator
5. **Navigate to each screen** as described above
6. **Take Screenshot:**
   - **Option A**: Press **Cmd + S** (saves to Desktop)
   - **Option B**: **Device** → **Screenshots** → **Save Screenshot**
   - **Option C**: **File** → **New Screen Recording** (for video)
7. **Screenshots are saved to Desktop** with names like:
   - `Simulator Screen Shot - iPhone 15 Pro Max - 2024-01-15 at 10.30.45.png`
8. **Verify resolution:**
   - Right-click screenshot → **Get Info**
   - Should show 1290 x 2796 pixels

### Method 2: Physical Device

1. **Connect iPhone** via USB
2. **Run app** from Xcode on device
3. **Navigate to each screen**
4. **Take screenshot:**
   - Press **Volume Up + Side Button** simultaneously
   - Screenshot saved to Photos app
5. **Transfer to Mac:**
   - Use AirDrop, or
   - Connect to Mac and import via Photos app
6. **Crop if needed:**
   - iPhone screenshots include status bar (which is fine)
   - If you need to crop, use Preview or Photos app

### Method 3: QuickTime Player (For Video)

1. **Connect iPhone** via USB
2. **Open QuickTime Player** on Mac
3. **File** → **New Movie Recording**
4. **Click dropdown** next to record button → Select your iPhone
5. **Record** your app in action (15-30 seconds)
6. **Save** as MP4

---

## Screenshot Editing Tips

### What You CAN Do:
- ✅ Keep status bars (Apple allows this)
- ✅ Crop to remove black bars if needed
- ✅ Adjust brightness/contrast slightly
- ✅ Add text overlays (sparingly, if at all)

### What You SHOULD NOT Do:
- ❌ Remove status bars (not necessary, Apple allows them)
- ❌ Heavily edit or manipulate content
- ❌ Use fake or misleading content
- ❌ Add excessive text overlays
- ❌ Use placeholder text

### Recommended Approach:
**Keep it simple and authentic.** Show the app as it actually works. Users appreciate honesty.

---

## Screenshot Checklist

Before uploading to App Store Connect:

- [ ] **Screenshot 1**: Home screen with verse (PRIMARY)
- [ ] **Screenshot 2**: Reading history calendar
- [ ] **Screenshot 3**: Favorites view
- [ ] **Screenshot 4**: Settings screen
- [ ] **Screenshot 5**: Share card example (optional)
- [ ] **Screenshot 6**: Multiple verses view (optional)

**For each screenshot, verify:**
- [ ] Resolution is 1290 x 2796 pixels
- [ ] Format is PNG or JPEG
- [ ] Content is clear and readable
- [ ] No placeholder text visible
- [ ] Shows real app functionality
- [ ] File size is reasonable (< 5MB per screenshot)

---

## Screenshot File Organization

Create a folder structure:

```
DailyVerse_Screenshots/
├── iPhone_15_Pro_Max_6.7/
│   ├── 01_Home_Screen.png
│   ├── 02_Reading_History.png
│   ├── 03_Favorites.png
│   ├── 04_Settings.png
│   ├── 05_Share_Card.png (optional)
│   └── 06_Multiple_Verses.png (optional)
└── README.txt (notes about each screenshot)
```

---

## Pro Tips

1. **First Screenshot is Critical**: Make it count! This is what users see first in the App Store.

2. **Show Real Data**: Use actual verses, real streaks, genuine favorites. Don't use placeholder text.

3. **Consistent Design**: All screenshots should feel cohesive and show the same design language.

4. **Highlight Key Features**: Each screenshot should showcase a different major feature.

5. **Test on Device**: While simulator is fine, testing on a real device ensures colors and layout look perfect.

6. **Multiple Attempts**: Take several screenshots of each screen and pick the best one.

7. **Time of Day**: Consider taking screenshots at different times to show the app in various states (with/without streaks, different verse counts, etc.)

---

## Troubleshooting

### Screenshot Resolution is Wrong
- **Problem**: Screenshot shows wrong resolution
- **Solution**: Make sure you're using iPhone 15 Pro Max simulator, not a different device

### Simulator Won't Launch
- **Problem**: Simulator crashes or won't start
- **Solution**: 
  1. Close Xcode
  2. Open Simulator app directly
  3. Device → Erase All Content and Settings
  4. Restart Simulator

### App Looks Different in Screenshot
- **Problem**: Layout looks off in screenshot
- **Solution**: 
  1. Make sure you're using the correct device size
  2. Check that app is fully loaded before screenshot
  3. Wait for animations to complete

### Can't See All Features
- **Problem**: Some features aren't visible
- **Solution**: 
  1. Scroll to show more content
  2. Use multiple screenshots to show different states
  3. Create test data (favorites, history, streaks) before taking screenshots

---

## Next Steps

Once you have your screenshots:

1. **Review each one** for quality and clarity
2. **Organize them** in the order you want them to appear
3. **Name them clearly** (e.g., `01_Home.png`, `02_History.png`)
4. **Upload to App Store Connect** when filling out version information
5. **Drag to reorder** in App Store Connect (first screenshot is most important)

Good luck! Your screenshots are the first impression users get of your app, so make them count! 📸✨
