# App Store Submission Checklist

Reusable checklist for iOS app submissions. Copy and check off items as you complete them.

## Pre-Submission (Before Archiving)

### Code & Configuration
- [ ] All debug code removed or wrapped in `#if DEBUG`
- [ ] No hardcoded values or workarounds
- [ ] App tested on real devices
- [ ] All features working correctly
- [ ] Bundle ID configured correctly
- [ ] Version number set (e.g., 1.0)
- [ ] Build number set (e.g., 1)
- [ ] Deployment target appropriate (consider iOS 16.0+ for broader reach)

### Info.plist
- [ ] `ITSAppUsesNonExemptEncryption` = `false` added (CRITICAL - prevents export compliance questions)
- [ ] No unnecessary permissions declared
- [ ] All required keys present

### Assets
- [ ] App icon (1024×1024px) ready
- [ ] App icon has no transparency
- [ ] Screenshots created (minimum 3, recommended 6)
- [ ] Screenshots are exact dimensions (1284 × 2778px for iPhone 6.7")
- [ ] Screenshots show key features
- [ ] Screenshots use real content (no placeholders)

### Support & Privacy
- [ ] Support URL created and working
- [ ] Privacy Policy URL created and working
- [ ] Both URLs tested and accessible

### Metadata Prepared
- [ ] App description written (plain text, NO emojis)
- [ ] What's New text written (plain text, NO emojis)
- [ ] Keywords prepared (comma-separated, plain text)
- [ ] Promotional text prepared (optional)

---

## Archive & Upload

- [ ] Xcode project opened
- [ ] Device selector set to "Any iOS Device" (NOT simulator)
- [ ] Clean Build Folder executed (Shift+Cmd+K)
- [ ] Archive created (Product → Archive)
- [ ] Archive verified (correct version and build)
- [ ] Build distributed to App Store Connect
- [ ] Upload completed successfully
- [ ] Build processing email received (wait 10-15 minutes)

---

## App Store Connect Setup

### App Information Tab
- [ ] App name entered (verify availability)
- [ ] Primary category selected (Lifestyle or Reference)
- [ ] Content Rights checked ("I have the rights to use all content")
- [ ] Age Rating questionnaire completed (should result in 4+)

### Version 1.0 Tab - Version Information
- [ ] What's New filled in (plain text, NO emojis)
- [ ] Description filled in (plain text, NO emojis)
- [ ] Keywords filled in (comma-separated, plain text)
- [ ] Support URL entered and validated
- [ ] Privacy Policy URL entered and validated
- [ ] Promotional Text filled in (optional)

### Version 1.0 Tab - Screenshots
- [ ] At least 3 screenshots uploaded
- [ ] Screenshots are correct dimensions
- [ ] First screenshot shows home/main screen
- [ ] Screenshots ordered correctly (drag to reorder)

### Version 1.0 Tab - Build
- [ ] Build appeared in list (after 10-15 min processing)
- [ ] Correct build selected
- [ ] Build shows as "Ready to Submit"

### Version 1.0 Tab - App Privacy
- [ ] App Privacy section opened
- [ ] "Does your app collect data?" → No
- [ ] "Does your app use encryption?" → No (or "Yes, but exempt")
- [ ] "Does your app use IDFA?" → No
- [ ] Changes saved

---

## Final Submission

### Pre-Submit Verification
- [ ] All required fields have green checkmarks ✅
- [ ] No red error messages visible
- [ ] Support URL works when clicked
- [ ] Privacy Policy URL works when clicked
- [ ] Screenshots display correctly
- [ ] Build is selected and ready

### Submit for Review
- [ ] Clicked "Submit for Review" (or "Add for Review")
- [ ] Demo Account: "No demo account required" (if applicable)
- [ ] Contact Information verified (email correct)
- [ ] Notes for Review added (optional but recommended)
- [ ] Submitted successfully

### Post-Submission
- [ ] Status changed to "Waiting for Review"
- [ ] Email confirmation received
- [ ] Monitoring for review status updates

---

## Common Issues Reference

### "Invalid characters in Description"
→ Remove all emojis, use plain text only

### "Screenshot dimensions are wrong"
→ Resize to exact dimensions (1284 × 2778px). Use `scripts/resize_screenshots.sh`

### "Export compliance warning"
→ Add `ITSAppUsesNonExemptEncryption` = `false` to Info.plist, create new archive

### "Support URL not working"
→ Verify GitHub Pages enabled, wait 1-2 min, or use `mailto:` temporarily

### "Build doesn't appear"
→ Wait 10-15 minutes, check email for processing notifications

---

## Timeline

- **Setup**: 1-2 hours
- **Review**: 24-48 hours (typical)
- **Can take**: Up to 7 days (rare)

---

## Notes

- Always increment build number for each submission
- Version can stay same for bug fixes
- Keep screenshots organized in folders by device size
- Save all metadata in `APP_STORE_DESCRIPTION.md` for reuse
