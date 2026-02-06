# App Store Submission Scripts

Automation scripts for iOS App Store submission.

## Available Scripts

### `resize_screenshots.sh`
Resizes screenshots to App Store Connect required dimensions.

**Usage:**
```bash
./scripts/resize_screenshots.sh [screenshot_directory]
```

**Default**: Resizes screenshots in `DailyVerse_Screenshots/iPhone_15_Pro_Max_6.7/`

**What it does:**
- Checks current dimensions
- Resizes to 1284 × 2778px (iPhone 6.7" requirement)
- Skips files already correct size
- Verifies final dimensions

---

### `verify_info_plist.sh`
Verifies Info.plist has required keys for App Store submission.

**Usage:**
```bash
./scripts/verify_info_plist.sh [Info.plist path]
```

**Default**: Checks `DailyVerse/Info.plist`

**What it checks:**
- Export compliance key (`ITSAppUsesNonExemptEncryption`)
- Bundle identifier
- Version number
- Build number

---

### `setup_github_pages_complete.sh`
Automatically creates support and privacy policy pages on GitHub Pages.

**Usage:**
```bash
./scripts/setup_github_pages_complete.sh
```

**Requirements:**
- GitHub CLI installed (`gh`)
- GitHub CLI authenticated (`gh auth login`)
- Support email address (prompted)

**What it does:**
- Creates HTML files with your email
- Creates/updates GitHub repository
- Enables GitHub Pages
- Provides URLs for App Store Connect

**Output:**
- Support URL: `https://yourusername.github.io/dailyverse-support/`
- Privacy URL: `https://yourusername.github.io/dailyverse-support/privacy.html`

---

## Quick Workflow

Before archiving your app:

```bash
# 1. Verify Info.plist
./scripts/verify_info_plist.sh

# 2. Resize screenshots
./scripts/resize_screenshots.sh

# 3. Set up support URLs (if needed)
./scripts/setup_github_pages_complete.sh
```

---

## Requirements

- macOS (for `sips` command in resize script)
- GitHub CLI (for Pages setup script)
- Bash 4.0+

---

## Troubleshooting

### "sips command not found"
→ You're not on macOS. Screenshot resizing requires macOS.

### "gh command not found"
→ Install GitHub CLI: `brew install gh`

### "GitHub CLI needs authentication"
→ Run `gh auth login` first

### "Screenshots already correct size"
→ Script will skip them, this is normal
