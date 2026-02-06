#!/bin/bash

# Complete GitHub Pages Setup Script for Daily Verse Reading
# This script will set up everything automatically

set -e

echo "🚀 Daily Verse Reading - GitHub Pages Setup"
echo "============================================"
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get user's email
echo -e "${BLUE}Step 1: Contact Information${NC}"
read -p "Enter your support email address: " SUPPORT_EMAIL

if [ -z "$SUPPORT_EMAIL" ]; then
    echo -e "${RED}❌ Email is required. Exiting.${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}Step 2: GitHub Authentication${NC}"
echo "Checking GitHub CLI authentication..."

if ! gh auth status &>/dev/null; then
    echo -e "${YELLOW}⚠️  GitHub CLI needs authentication${NC}"
    echo "Please run: gh auth login"
    echo "Then run this script again."
    exit 1
fi

GITHUB_USERNAME=$(gh api user --jq .login)
echo -e "${GREEN}✅ Authenticated as: $GITHUB_USERNAME${NC}"

REPO_NAME="dailyverse-support"
REPO_DIR="/tmp/$REPO_NAME"

echo ""
echo -e "${BLUE}Step 3: Creating HTML files...${NC}"

# Create temporary directory
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR"
cd "$REPO_DIR"

# Create index.html (support page)
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily Verse Reading - Support</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            line-height: 1.6;
            color: #333;
            background: #f5f5f5;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            margin-bottom: 10px;
            font-size: 2.5em;
        }
        .subtitle {
            color: #7f8c8d;
            margin-bottom: 30px;
            font-size: 1.1em;
        }
        h2 {
            color: #34495e;
            margin-top: 30px;
            margin-bottom: 15px;
            font-size: 1.5em;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }
        h3 {
            color: #2c3e50;
            margin-top: 20px;
            margin-bottom: 10px;
            font-size: 1.2em;
        }
        p {
            margin-bottom: 15px;
            color: #555;
        }
        .contact-box {
            background: #ecf0f1;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
        }
        .contact-box a {
            color: #3498db;
            text-decoration: none;
            font-weight: 600;
        }
        .contact-box a:hover {
            text-decoration: underline;
        }
        ul {
            margin-left: 20px;
            margin-bottom: 15px;
        }
        li {
            margin-bottom: 10px;
            color: #555;
        }
        .footer {
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid #ecf0f1;
            text-align: center;
            color: #95a5a6;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Daily Verse Reading</h1>
        <p class="subtitle">Daily Bible Reading App - Support</p>
        
        <h2>📧 Contact Us</h2>
        <div class="contact-box">
            <p>If you have questions, feedback, or need help, please contact us:</p>
            <p><strong>Email:</strong> <a href="mailto:SUPPORT_EMAIL_PLACEHOLDER">SUPPORT_EMAIL_PLACEHOLDER</a></p>
        </div>
        
        <h2>❓ Frequently Asked Questions</h2>
        
        <h3>How do I enable daily notifications?</h3>
        <ul>
            <li>Open the app</li>
            <li>Tap the menu icon (three dots) in the top right</li>
            <li>Go to "App Settings"</li>
            <li>Tap "Enable Notifications"</li>
            <li>Set your preferred reminder time</li>
        </ul>
        
        <h3>How does the streak tracking work?</h3>
        <p>Your streak increases each day you mark a verse as read. The streak resets if you miss a day. You can view your current streak and longest streak on the home screen.</p>
        
        <h3>Can I use the app offline?</h3>
        <p>Yes! Daily Verse Reading works completely offline. All verses are stored on your device, so you can read them anytime without an internet connection.</p>
        
        <h3>How do I share verses?</h3>
        <ul>
            <li>Tap the share button below any verse to share it as an image</li>
            <li>Or use "Share Verses" to share multiple verses at once</li>
            <li>You can choose to share as images or text</li>
        </ul>
        
        <h3>How do I save favorite verses?</h3>
        <p>Tap the star icon next to any verse to save it to your favorites. View all favorites by tapping the star icon in the top navigation bar.</p>
        
        <h3>Where is my data stored?</h3>
        <p>All your data (reading history, favorites, streaks) is stored locally on your device. We don't collect or transmit any personal information.</p>
        
        <h2>🐛 Report a Bug</h2>
        <p>If you encounter any issues or bugs, please email us at <a href="mailto:SUPPORT_EMAIL_PLACEHOLDER">SUPPORT_EMAIL_PLACEHOLDER</a> with:</p>
        <ul>
            <li>Description of the issue</li>
            <li>Steps to reproduce (if possible)</li>
            <li>Your device model and iOS version</li>
        </ul>
        
        <h2>💡 Feature Requests</h2>
        <p>We'd love to hear your ideas! Send feature requests to <a href="mailto:SUPPORT_EMAIL_PLACEHOLDER">SUPPORT_EMAIL_PLACEHOLDER</a></p>
        
        <div class="footer">
            <p>Daily Verse Reading - Building daily Bible reading habits, one verse at a time.</p>
            <p>&copy; 2024 Daily Verse Reading. All rights reserved.</p>
        </div>
    </div>
</body>
</html>
EOF

# Replace email placeholder in index.html
sed -i '' "s/SUPPORT_EMAIL_PLACEHOLDER/$SUPPORT_EMAIL/g" index.html

# Create privacy.html
cat > privacy.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily Verse Reading - Privacy Policy</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            line-height: 1.6;
            color: #333;
            background: #f5f5f5;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            margin-bottom: 10px;
            font-size: 2.5em;
        }
        .subtitle {
            color: #7f8c8d;
            margin-bottom: 30px;
            font-size: 1.1em;
        }
        h2 {
            color: #34495e;
            margin-top: 30px;
            margin-bottom: 15px;
            font-size: 1.5em;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }
        p {
            margin-bottom: 15px;
            color: #555;
        }
        .last-updated {
            color: #95a5a6;
            font-size: 0.9em;
            margin-bottom: 30px;
        }
        .footer {
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid #ecf0f1;
            text-align: center;
            color: #95a5a6;
            font-size: 0.9em;
        }
        a {
            color: #3498db;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Privacy Policy</h1>
        <p class="subtitle">Daily Verse Reading</p>
        <p class="last-updated">Last Updated: <span id="date"></span></p>
        
        <h2>Our Commitment to Privacy</h2>
        <p>Daily Verse Reading is committed to protecting your privacy. This policy explains how we handle information in our app.</p>
        
        <h2>Data Collection</h2>
        <p><strong>Daily Verse Reading does not collect, store, or transmit any personal information.</strong> The app operates entirely offline and does not connect to any external servers.</p>
        
        <h2>Local Storage</h2>
        <p>All data is stored locally on your device using iOS UserDefaults. This includes:</p>
        <ul>
            <li>Reading history (which verses you've read and when)</li>
            <li>Favorite verses</li>
            <li>Streak information</li>
            <li>Notification preferences</li>
        </ul>
        <p><strong>This data never leaves your device.</strong> It is not transmitted to us or any third parties.</p>
        
        <h2>Third-Party Services</h2>
        <p>Daily Verse Reading does not use any third-party services, including:</p>
        <ul>
            <li>Analytics services</li>
            <li>Advertising networks</li>
            <li>Tracking services</li>
            <li>Crash reporting services</li>
            <li>Social media integrations</li>
        </ul>
        
        <h2>Notifications</h2>
        <p>Daily Verse Reading uses local notifications only (not push notifications). These notifications are scheduled and delivered entirely by your device's operating system. We do not have access to notification delivery data.</p>
        
        <h2>Network Access</h2>
        <p>Daily Verse Reading does not require or use an internet connection. All Bible verses are included in the app and stored on your device.</p>
        
        <h2>Children's Privacy</h2>
        <p>Daily Verse Reading is suitable for all ages. Since we do not collect any personal information, we do not knowingly collect information from children or anyone else.</p>
        
        <h2>Changes to This Policy</h2>
        <p>We may update this privacy policy from time to time. Any changes will be posted on this page with an updated "Last Updated" date.</p>
        
        <h2>Contact Us</h2>
        <p>If you have questions about this privacy policy, please contact us at:</p>
        <p><strong>Email:</strong> <a href="mailto:SUPPORT_EMAIL_PLACEHOLDER">SUPPORT_EMAIL_PLACEHOLDER</a></p>
        
        <div class="footer">
            <p>Daily Verse Reading - Building daily Bible reading habits, one verse at a time.</p>
            <p>&copy; 2024 Daily Verse Reading. All rights reserved.</p>
        </div>
    </div>
    
    <script>
        // Auto-fill current date
        document.getElementById('date').textContent = new Date().toLocaleDateString('en-US', { 
            year: 'numeric', 
            month: 'long', 
            day: 'numeric' 
        });
    </script>
</body>
</html>
EOF

# Replace email placeholder in privacy.html
sed -i '' "s/SUPPORT_EMAIL_PLACEHOLDER/$SUPPORT_EMAIL/g" privacy.html

# Create README
cat > README.md << EOF
# Daily Verse Reading - Support Pages

This repository contains the support and privacy policy pages for Daily Verse Reading iOS app.

## Pages

- **Support**: [index.html](index.html) - Main support page with FAQs and contact information
- **Privacy Policy**: [privacy.html](privacy.html) - Privacy policy for the app

## GitHub Pages

These pages are hosted on GitHub Pages at:
- Support: https://$GITHUB_USERNAME.github.io/$REPO_NAME/
- Privacy: https://$GITHUB_USERNAME.github.io/$REPO_NAME/privacy.html

## App Store URLs

Use these URLs in App Store Connect:
- **Support URL**: https://$GITHUB_USERNAME.github.io/$REPO_NAME/
- **Privacy Policy URL**: https://$GITHUB_USERNAME.github.io/$REPO_NAME/privacy.html
EOF

echo -e "${GREEN}✅ Files created successfully!${NC}"
echo ""

# Initialize git repo
echo -e "${BLUE}Step 4: Initializing git repository...${NC}"
git init
git add .
git commit -m "Initial commit: Support and Privacy Policy pages"

echo ""
echo -e "${GREEN}✅ Local repository created!${NC}"
echo ""

# Check if repository exists
echo -e "${BLUE}Step 5: Checking if repository exists on GitHub...${NC}"
if gh repo view "$GITHUB_USERNAME/$REPO_NAME" &>/dev/null; then
    echo -e "${YELLOW}⚠️  Repository already exists. Updating...${NC}"
    git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git" 2>/dev/null || git remote set-url origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
    git branch -M main
    git push -u origin main --force
else
    echo -e "${BLUE}Creating new repository on GitHub...${NC}"
    gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
fi

echo ""
echo -e "${BLUE}Step 6: Enabling GitHub Pages...${NC}"
gh api repos/$GITHUB_USERNAME/$REPO_NAME/pages -X POST -f source='{"branch":"main","path":"/"}' 2>/dev/null || \
gh api repos/$GITHUB_USERNAME/$REPO_NAME/pages -X PUT -f source='{"branch":"main","path":"/"}'

echo ""
echo -e "${GREEN}✅ GitHub Pages enabled!${NC}"
echo ""
echo -e "${YELLOW}⏳ Wait 1-2 minutes for GitHub Pages to deploy...${NC}"
echo ""
echo -e "${GREEN}✅ Setup Complete!${NC}"
echo ""
echo "Your URLs:"
echo -e "${GREEN}  Support: https://$GITHUB_USERNAME.github.io/$REPO_NAME/${NC}"
echo -e "${GREEN}  Privacy: https://$GITHUB_USERNAME.github.io/$REPO_NAME/privacy.html${NC}"
echo ""
echo "Use these URLs in App Store Connect!"
