---
name: app-store-submission
description: Guides iOS app submission to App Store with automated checks, common pitfalls, and step-by-step workflows. Use when submitting iOS apps to App Store, preparing for App Store Connect, or when the user mentions App Store submission, review, or distribution.
---

# App Store Submission Guide

Complete workflow for submitting iOS apps to the App Store with automation and common pitfalls.

## Quick Checklist

Before starting, verify:
- [ ] App is production-ready (no debug code, tested)
- [ ] Bundle ID configured
- [ ] Version and Build numbers set
- [ ] App icon (1024x1024) ready
- [ ] Screenshots prepared

## Pre-Submission Setup

### 1. Export Compliance (CRITICAL - Do First)

Add to `Info.plist` before archiving:

```xml
<key>ITSAppUsesNonExemptEncryption</key>
<false/>
```

**Why**: Prevents export compliance questions during upload. Required for all apps.

### 2. Screenshot Dimensions

App Store Connect requires exact dimensions. Common sizes:
- **iPhone 6.7" (15 Pro Max)**: 1284 × 2778px (portrait)
- **iPhone 6.5" (14 Pro Max)**: 1284 × 2778px (portrait)

**Automation**: Use `scripts/resize_screenshots.sh` to resize screenshots automatically.

**Gotcha**: Simulator screenshots are often 1290 × 2796px - must be resized to 1284 × 2778px.

### 3. App Store Connect Metadata

**CRITICAL**: App Store Connect does NOT accept emojis in:
- Description
- What's New
- Keywords (use plain text only)

**Template**: Use plain text versions from `APP_STORE_DESCRIPTION.md` (no emoji versions).

### 4. Support & Privacy URLs

**Required URLs**:
- Support URL (required)
- Privacy Policy URL (may be required)

**Quick Setup**: Run `scripts/setup_github_pages.sh` to create both pages automatically.

**Alternative**: Use `mailto:your-email@example.com` as temporary URLs.

## Submission Workflow

### Phase 1: Archive & Upload

1. **Clean Build**: Product → Clean Build Folder (Shift+Cmd+K)
2. **Select Device**: "Any iOS Device" (NOT simulator)
3. **Archive**: Product → Archive
4. **Distribute**: Select archive → Distribute App → App Store Connect → Upload

### Phase 2: App Store Connect Setup

#### App Information Tab
- Category: Lifestyle or Reference
- Content Rights: Check "I have the rights to use all content"
- Age Rating: Complete questionnaire (should be 4+ for most apps)

#### Version Information
- What's New: Plain text (no emojis)
- Description: Plain text (no emojis)
- Keywords: Comma-separated, plain text
- Support URL: Valid URL
- Privacy Policy URL: Valid URL

#### Screenshots
- Upload at least 3 screenshots
- Verify dimensions are exact (1284 × 2778px for 6.7")
- First screenshot is most important

#### Build Selection
- Wait 10-15 minutes after upload for processing
- Select the new build (not old ones)

#### App Privacy
- Does your app collect data? → **No** (for offline apps)
- Does your app use encryption? → **No** (or "Yes, but exempt")
- Does your app use IDFA? → **No**

### Phase 3: Submit for Review

1. Verify all fields have green checkmarks ✅
2. Click "Submit for Review"
3. Answer:
   - Demo Account: "No demo account required" (if applicable)
   - Contact Information: Your email
   - Notes for Review: (Optional) Brief explanation of app functionality

## Common Issues & Solutions

### Issue: "Invalid characters in Description"
**Solution**: Remove all emojis. Use plain text only.

### Issue: "Screenshot dimensions are wrong"
**Solution**: Resize to exact dimensions (1284 × 2778px). Use `scripts/resize_screenshots.sh`.

### Issue: "Export compliance warning"
**Solution**: Add `ITSAppUsesNonExemptEncryption` = `false` to Info.plist before archiving.

### Issue: "Support URL not working"
**Solution**: 
1. Verify GitHub Pages is enabled (Settings → Pages)
2. Wait 1-2 minutes for deployment
3. Use `mailto:` link as temporary workaround

### Issue: "Build doesn't appear"
**Solution**: Wait 10-15 minutes. Check email for processing notifications.

## Automation Scripts

Located in `scripts/`:
- `resize_screenshots.sh` - Resize screenshots to correct dimensions
- `setup_github_pages.sh` - Create support/privacy pages automatically
- `verify_info_plist.sh` - Check Info.plist for required keys

## Reference Files

- `APP_STORE_DESCRIPTION.md` - Pre-written metadata (plain text versions)
- `NEXT_STEPS.md` - Detailed step-by-step checklist
- `APP_STORE_SUBMISSION_GUIDE.md` - Complete reference guide

## Key Learnings

1. **Always add export compliance key** before first archive
2. **Screenshots must be exact dimensions** - simulator outputs wrong size
3. **No emojis in App Store Connect** - causes validation errors
4. **GitHub Pages setup** can be automated with script
5. **Build processing takes 10-15 minutes** - plan accordingly
