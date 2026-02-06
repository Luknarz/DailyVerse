# App Store Submission Resources

Complete resource guide for iOS App Store submissions. All learnings from Daily Verse Reading submission are captured here.

## 🎯 Quick Navigation

- **First time?** → Start with `QUICK_START_SUBMISSION.md`
- **Need detailed steps?** → Use `APP_STORE_SUBMISSION_CHECKLIST.md`
- **Want automation?** → See `scripts/README.md`
- **Looking for gotchas?** → Read `LEARNINGS.md`

## 📁 Resource Files

### Quick References
- **`QUICK_START_SUBMISSION.md`** - 5-minute pre-flight check and quick checklist
- **`APP_STORE_SUBMISSION_CHECKLIST.md`** - Complete reusable checklist
- **`APP_STORE_DESCRIPTION.md`** - Metadata templates (plain text, no emojis)

### Detailed Guides
- **`APP_STORE_SUBMISSION_GUIDE.md`** - Complete step-by-step reference
- **`NEXT_STEPS.md`** - Original step-by-step guide (now with automation notes)
- **`LEARNINGS.md`** - Key learnings and gotchas

### Automation
- **`scripts/resize_screenshots.sh`** - Auto-resize screenshots
- **`scripts/verify_info_plist.sh`** - Verify Info.plist before archiving
- **`scripts/setup_github_pages_complete.sh`** - Auto-create support/privacy pages

### AI Agent Support
- **`.cursor/skills/app-store-submission/SKILL.md`** - AI agent skill for automated help

### Templates
- **`support-page-template.html`** - Support page HTML template
- **`privacy-policy-template.html`** - Privacy policy HTML template

## 🚀 For Your Next App

### Step 1: Pre-Flight (5 minutes)
```bash
# Verify Info.plist
./scripts/verify_info_plist.sh

# Resize screenshots
./scripts/resize_screenshots.sh

# Set up URLs (if needed)
./scripts/setup_github_pages_complete.sh
```

### Step 2: Archive & Upload (30 minutes)
- Follow `QUICK_START_SUBMISSION.md` checklist
- Archive in Xcode
- Upload to App Store Connect

### Step 3: Fill Metadata (30 minutes)
- Use `APP_STORE_DESCRIPTION.md` for text (plain text versions!)
- Upload screenshots
- Complete App Privacy section

### Step 4: Submit (5 minutes)
- Final verification
- Submit for review

## ⚠️ Critical Gotchas

1. **Export Compliance**: Add `ITSAppUsesNonExemptEncryption` = `false` to Info.plist BEFORE archiving
2. **Screenshot Dimensions**: Must be exactly 1284 × 2778px (use resize script)
3. **No Emojis**: App Store Connect rejects emojis in metadata
4. **URLs Must Work**: Test support and privacy URLs before submitting

## 📊 Time Savings

| Task | Manual | Automated | Saved |
|------|--------|-----------|-------|
| Screenshot resizing | 15 min | 2 min | 13 min |
| GitHub Pages setup | 30 min | 5 min | 25 min |
| Info.plist verification | 5 min | 1 min | 4 min |
| **Total** | **50 min** | **8 min** | **42 min** |

## 🔄 Reusable Components

### For Each New App:
1. Copy `APP_STORE_SUBMISSION_CHECKLIST.md` → Check off items
2. Copy `APP_STORE_DESCRIPTION.md` → Customize for your app
3. Run automation scripts → Save time
4. Use AI skill → Get automated guidance

### Scripts Work For:
- Any iOS app
- Any screenshot directory
- Any Info.plist location
- Any GitHub username

## 🎓 Key Learnings

1. **Automate early** - Scripts save significant time
2. **Checklist everything** - Prevents missing steps
3. **Test URLs immediately** - Catch issues early
4. **Plain text metadata** - Avoids validation errors
5. **Export compliance first** - Prevents upload blockers

## 📝 Notes

- All scripts are macOS-compatible (use `sips` for image processing)
- GitHub CLI required for Pages setup script
- Scripts are idempotent (safe to run multiple times)
- All templates use placeholders you can customize

## 🔗 Related Files

- `APP_ICON_CREATION_GUIDE.md` - App icon creation guide
- `SCREENSHOT_GUIDE.md` - Screenshot creation guide
- `SUPPORT_PAGE_SETUP.md` - Manual GitHub Pages setup (if script fails)

---

**Last Updated**: Based on Daily Verse Reading submission (January 2025)
