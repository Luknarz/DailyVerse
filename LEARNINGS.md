# App Store Submission Learnings

Key learnings from Daily Verse Reading App Store submission to streamline future submissions.

## Critical Gotchas

### 1. Export Compliance (MUST DO FIRST)
**Issue**: Export compliance questions appear during upload, blocking progress.

**Solution**: Add to `Info.plist` BEFORE first archive:
```xml
<key>ITSAppUsesNonExemptEncryption</key>
<false/>
```

**Why**: Prevents export compliance questions. Required for all apps, even offline ones.

**When**: Add this immediately when preparing for submission, before any archive.

---

### 2. Screenshot Dimensions Must Be Exact
**Issue**: App Store Connect rejects screenshots that are even slightly off.

**Problem**: iOS Simulator outputs 1290 × 2796px, but App Store Connect requires exactly 1284 × 2778px for iPhone 6.7".

**Solution**: 
- Use `scripts/resize_screenshots.sh` to automatically resize
- Or manually resize using `sips -z 2778 1284 filename.png`

**When**: After creating screenshots, before uploading to App Store Connect.

---

### 3. No Emojis in App Store Connect
**Issue**: App Store Connect validation fails with "invalid characters" error.

**Problem**: Emojis in Description, What's New, or Keywords cause validation errors.

**Solution**: 
- Always use plain text versions
- Remove all emojis from metadata
- Keep emoji versions for reference, but use plain text for submission

**When**: When preparing metadata, create both versions (with and without emojis).

---

### 4. GitHub Pages Setup Can Be Automated
**Issue**: Manual setup of support/privacy pages is time-consuming.

**Solution**: 
- Use `scripts/setup_github_pages_complete.sh`
- Requires: GitHub CLI authenticated (`gh auth login`)
- Automates: Repository creation, file generation, Pages enablement

**When**: Before filling out App Store Connect metadata.

---

### 5. Build Processing Takes Time
**Issue**: Build doesn't appear immediately after upload.

**Solution**: 
- Wait 10-15 minutes after upload
- Check email for processing notifications
- Build will appear automatically when ready

**When**: After uploading build, use waiting time to fill out metadata.

---

## Automation Opportunities

### What Can Be Automated
1. ✅ Screenshot resizing (`scripts/resize_screenshots.sh`)
2. ✅ GitHub Pages setup (`scripts/setup_github_pages_complete.sh`)
3. ✅ Info.plist verification (`scripts/verify_info_plist.sh`)
4. ✅ Export compliance key addition (can be scripted)

### What Requires Manual Steps
1. Archive creation in Xcode (requires Xcode UI)
2. Build upload (can be automated but Xcode UI is easier)
3. App Store Connect metadata entry (web UI required)
4. Screenshot creation (requires simulator/device)

---

## Best Practices

### 1. Prepare Everything Before Archiving
- Add export compliance key
- Create screenshots and resize them
- Set up support/privacy URLs
- Prepare all metadata (plain text versions)

### 2. Use Checklists
- Copy `APP_STORE_SUBMISSION_CHECKLIST.md` for each app
- Check off items as you complete them
- Prevents missing critical steps

### 3. Keep Metadata Organized
- Store in `APP_STORE_DESCRIPTION.md`
- Include both emoji and plain text versions
- Version control for easy reuse

### 4. Test URLs Before Submission
- Verify support URL works
- Verify privacy URL works
- Test from different devices/networks

### 5. Increment Build Number
- Each submission needs new build number
- Version can stay same for bug fixes
- Build must always increase

---

## Workflow Optimization

### Recommended Order
1. **Pre-flight checks** (30 min)
   - Verify Info.plist has export compliance key
   - Create/resize screenshots
   - Set up support/privacy URLs

2. **Archive & Upload** (30 min)
   - Clean build
   - Create archive
   - Upload to App Store Connect

3. **Fill Metadata** (30 min, while build processes)
   - App Information
   - Version Information
   - Screenshots
   - App Privacy

4. **Submit** (5 min)
   - Final verification
   - Submit for review

**Total**: ~2 hours of work, then wait for review

---

## Reusable Resources

### Scripts
- `scripts/resize_screenshots.sh` - Resize screenshots automatically
- `scripts/setup_github_pages_complete.sh` - Create support/privacy pages
- `scripts/verify_info_plist.sh` - Check Info.plist before archiving

### Templates
- `APP_STORE_DESCRIPTION.md` - Metadata template (plain text)
- `APP_STORE_SUBMISSION_CHECKLIST.md` - Reusable checklist
- `support-page-template.html` - Support page template
- `privacy-policy-template.html` - Privacy policy template

### Documentation
- `APP_STORE_SUBMISSION_GUIDE.md` - Complete reference guide
- `NEXT_STEPS.md` - Step-by-step instructions
- `.cursor/skills/app-store-submission/SKILL.md` - AI agent skill

---

## Future Improvements

### Potential Automations
1. **Auto-add export compliance key** - Script to add to Info.plist
2. **Screenshot automation** - Script to capture from simulator
3. **Metadata validation** - Check for emojis before submission
4. **Build number increment** - Auto-increment in Info.plist

### Documentation Improvements
1. Add device-specific screenshot dimensions table
2. Add common rejection reasons and fixes
3. Add expedited review process guide
4. Add post-approval checklist

---

## Key Metrics

- **Time to first submission**: ~2 hours (with automation)
- **Common blockers**: Export compliance, screenshot dimensions, emojis
- **Review time**: 24-48 hours typical
- **Success rate**: High (when checklist followed)

---

## Lessons Learned

1. **Automate early** - Scripts save time on repeated tasks
2. **Checklist everything** - Prevents missing critical steps
3. **Test URLs immediately** - Catch issues before submission
4. **Plain text metadata** - Avoids validation errors
5. **Export compliance first** - Prevents upload blockers
