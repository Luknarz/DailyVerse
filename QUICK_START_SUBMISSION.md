# Quick Start: App Store Submission

Fast-track guide for submitting iOS apps. Use this for your next app!

## 🚀 5-Minute Pre-Flight Check

Run these before archiving:

```bash
# 1. Verify Info.plist has export compliance key
./scripts/verify_info_plist.sh

# 2. Resize screenshots to correct dimensions
./scripts/resize_screenshots.sh

# 3. Set up support/privacy URLs (if needed)
./scripts/setup_github_pages_complete.sh
```

## 📋 Quick Checklist

### Before Archiving
- [ ] Export compliance key in Info.plist (`ITSAppUsesNonExemptEncryption` = `false`)
- [ ] Screenshots resized (1284 × 2778px for iPhone 6.7")
- [ ] Support URL working
- [ ] Privacy Policy URL working

### Archive & Upload
- [ ] Select "Any iOS Device"
- [ ] Clean Build Folder
- [ ] Archive
- [ ] Upload to App Store Connect

### App Store Connect
- [ ] App Information: Category, Content Rights, Age Rating
- [ ] Version Information: Description (NO emojis), Keywords, URLs
- [ ] Screenshots: At least 3, correct dimensions
- [ ] Build: Select uploaded build
- [ ] App Privacy: No data collection, no encryption, no IDFA

### Submit
- [ ] All green checkmarks ✅
- [ ] Submit for Review

## ⚠️ Common Mistakes to Avoid

1. **Forgetting export compliance key** → Add to Info.plist BEFORE archiving
2. **Wrong screenshot dimensions** → Use `resize_screenshots.sh`
3. **Emojis in metadata** → Use plain text only
4. **Broken URLs** → Test before submitting

## 📚 Full Resources

- **Detailed Checklist**: `APP_STORE_SUBMISSION_CHECKLIST.md`
- **Complete Guide**: `APP_STORE_SUBMISSION_GUIDE.md`
- **Learnings**: `LEARNINGS.md`
- **AI Skill**: `.cursor/skills/app-store-submission/SKILL.md`

## 🎯 Estimated Time

- Pre-flight: 30 minutes
- Archive & Upload: 30 minutes
- Metadata Entry: 30 minutes
- **Total**: ~2 hours

Then wait 24-48 hours for review.
