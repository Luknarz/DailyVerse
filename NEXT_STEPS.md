# Next Steps to Submit to App Store

> **Quick Start**: For your next app, use `QUICK_START_SUBMISSION.md` for a streamlined workflow.
> 
> **Automation**: Run `./scripts/verify_info_plist.sh` and `./scripts/resize_screenshots.sh` before archiving.

## ✅ Completed
- [x] Screenshots created and organized (12 screenshots in `DailyVerse_Screenshots/iPhone_15_Pro_Max_6.7/`)
- [x] App code is production-ready
- [x] App icon present
- [x] All metadata prepared (see `APP_STORE_DESCRIPTION.md`)
- [x] Support URL & Privacy Policy URL created (GitHub Pages: https://lukaszens.github.io/dailyverse-support/)

## 🔴 Critical Next Steps (Do These First)

### 1. ✅ Create Support URL & Privacy Policy URL (COMPLETED)

**Option A: GitHub Pages (Recommended - Free)**
1. Go to [github.com](https://github.com) and create a new repository: `dailyverse-support`
2. Make it **Public**
3. Create `index.html` file (use `support-page-template.html` from this repo)
4. Create `privacy.html` file (use `privacy-policy-template.html` from this repo)
5. Replace `your-email@example.com` with your actual email in both files
6. Enable GitHub Pages in repository Settings → Pages
7. Your URLs will be:
   - Support: `https://yourusername.github.io/dailyverse-support`
   - Privacy: `https://yourusername.github.io/dailyverse-support/privacy.html`

**Option B: Quick Email Link (Fastest)**
- Support URL: `mailto:your-email@example.com`
- Privacy URL: `mailto:your-email@example.com` (or same as support)

**✅ COMPLETED:**
- Support URL: https://lukaszens.github.io/dailyverse-support/
- Privacy Policy URL: https://lukaszens.github.io/dailyverse-support/privacy.html

---

### 2. Archive Your App in Xcode (15 minutes) ⬅️ **NEXT STEP**

1. **Open Xcode** and open your DailyVerse project
2. **Select "Any iOS Device"** in the device selector (top toolbar)
   - If it doesn't appear, connect a physical iPhone via USB
3. **Product → Clean Build Folder** (Shift+Cmd+K)
4. **Product → Archive**
5. Wait for archive to complete (5-10 minutes)
6. **Organizer** window will open automatically
7. Verify archive shows:
   - Version: 1.0
   - Build: 1 (or increment if you've submitted before)

---

### 3. Create App in App Store Connect (10 minutes)

1. Go to [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
2. Sign in with your Apple Developer account
3. Click **My Apps** → **+** → **New App**
4. Fill in:
   - **Platform**: iOS
   - **Name**: "Daily Verse Reading" (verify it's available)
   - **Primary Language**: English
   - **Bundle ID**: Select `com.dailyversereading.app`
   - **SKU**: `dailyverse-001` (any unique ID)
   - **User Access**: Full Access
5. Click **Create**

---

### 4. Upload Your Build (20 minutes)

1. In Xcode **Organizer**, select your archive
2. Click **Distribute App**
3. Select **App Store Connect**
4. Click **Next**
5. Select **Upload**
6. Click **Next**
7. Review options (leave defaults)
8. Click **Next**
9. Select certificates (Xcode auto-selects)
10. Click **Next**
11. Review summary
12. Click **Upload**
13. Wait 10-30 minutes for upload and processing

---

### 5. Fill Out App Store Connect Metadata (30 minutes)

Once your build is processed (10-15 minutes after upload):

#### App Information Tab
- [ ] **Category**: Primary: Lifestyle or Reference
- [ ] **Content Rights**: Check "I have the rights to use all content"
- [ ] **Age Rating**: Complete questionnaire → Should be **4+**

#### Version 1.0 Tab
1. **Version Information**:
   - [ ] **What's New**: Copy from `APP_STORE_DESCRIPTION.md`
   - [ ] **Description**: Copy from `APP_STORE_DESCRIPTION.md`
   - [ ] **Keywords**: Copy from `APP_STORE_DESCRIPTION.md`
   - [ ] **Support URL**: Enter your support URL
   - [ ] **Privacy Policy URL**: Enter your privacy policy URL
   - [ ] **Promotional Text**: Copy from `APP_STORE_DESCRIPTION.md` (optional)

2. **App Preview and Screenshots**:
   - [ ] Upload screenshots from `DailyVerse_Screenshots/iPhone_15_Pro_Max_6.7/`
   - [ ] Upload at least 3 (recommended: 6)
   - [ ] Drag to reorder (first is most important)
   - [ ] Use: `01_Home_Screen.png`, `02_Reading_History.png`, `03_Favorites.png`, `04_Settings.png`, `05_Share_Verses.png`, `06_Multiple_Verses.png`

3. **Build**:
   - [ ] Wait for build to appear (may take 10-15 minutes)
   - [ ] Click **+** next to Build
   - [ ] Select your uploaded build
   - [ ] Click **Done**

4. **App Privacy**:
   - [ ] Click **Edit**
   - [ ] **Does your app collect data?** → **No**
   - [ ] **Does your app use encryption?** → **No** (or "Yes, but exempt")
   - [ ] **Does your app use IDFA?** → **No**
   - [ ] Click **Save**

---

### 6. Submit for Review (5 minutes)

1. Scroll to top of version page
2. Verify all required fields have green checkmarks ✅
3. Click **Add for Review** (or **Submit for Review**)
4. Answer questions:
   - **Demo Account**: "No demo account required"
   - **Contact Information**: Your email (pre-filled)
   - **Notes for Review**: (Optional) Copy from `APP_STORE_DESCRIPTION.md`
5. Click **Submit**

---

## ⏱️ Timeline

- **Setup Support/Privacy URLs**: 30 minutes
- **Archive & Upload**: 30 minutes
- **App Store Connect Setup**: 45 minutes
- **Total**: ~2 hours

- **Review Time**: 24-48 hours (typical)
- **Can take**: Up to 7 days (rare)

---

## 📋 Quick Reference

- **Screenshots**: `DailyVerse_Screenshots/iPhone_15_Pro_Max_6.7/`
- **App Description**: `APP_STORE_DESCRIPTION.md`
- **Support Template**: `support-page-template.html`
- **Privacy Template**: `privacy-policy-template.html`
- **Full Guide**: `APP_STORE_SUBMISSION_GUIDE.md`

---

## 🎯 Recommended Order

1. ✅ Create Support & Privacy URLs (30 min) - **DONE**
2. ⬅️ **Archive app in Xcode (15 min)** - **NEXT**
3. ✅ Create app in App Store Connect (10 min)
4. ✅ Upload build (20 min)
5. ✅ Fill out metadata while build processes (30 min)
6. ✅ Submit for review (5 min)

**Total: ~2 hours of work, then wait 24-48 hours for review**

---

## 🚨 Common Issues

**Build doesn't appear in App Store Connect?**
- Wait 10-15 minutes after upload
- Check email for processing notifications
- Verify bundle ID matches

**App name is taken?**
- Try: "Daily Verse Reading - Bible", "Daily Verse Reading Daily", etc.

**Missing required fields?**
- All fields with red asterisks (*) must be filled
- Check for green checkmarks ✅

---

Good luck! 🚀
