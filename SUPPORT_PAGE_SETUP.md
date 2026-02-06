# Easiest Ways to Set Up Support Page

## 🚀 **Option 1: GitHub Pages (RECOMMENDED - Free & Easiest)**

### Step 1: Create GitHub Repository
1. Go to [github.com](https://github.com) and sign in
2. Click **"+"** → **"New repository"**
3. Name it: `dailyverse-support` (or any name)
4. Make it **Public**
5. Check **"Add a README file"**
6. Click **"Create repository"**

### Step 2: Create Support Page
1. In your new repository, click **"Add file"** → **"Create new file"**
2. Name it: `index.html`
3. Copy and paste the HTML template below
4. Replace `your-email@example.com` with your actual email
5. Click **"Commit new file"**

### Step 3: Enable GitHub Pages
1. Go to repository **Settings** tab
2. Scroll to **"Pages"** section (left sidebar)
3. Under **"Source"**, select **"Deploy from a branch"**
4. Select **"main"** branch and **"/ (root)"** folder
5. Click **"Save"**
6. Wait 1-2 minutes, then your site will be live at:
   `https://yourusername.github.io/dailyverse-support`

**That's it!** Your support page is live in under 5 minutes.

---

## 📧 **Option 2: Simple Email Link (Simplest)**

If you just need a URL quickly, you can use a `mailto:` link:

**Support URL**: `mailto:your-email@example.com`

**Note**: Some reviewers prefer actual web pages, but `mailto:` links are technically valid URLs.

---

## 🌐 **Option 3: Carrd (Free, No Coding)**

1. Go to [carrd.co](https://carrd.co)
2. Sign up (free)
3. Choose a template
4. Add:
   - Contact email
   - Brief FAQ
   - App description
5. Publish
6. Get your URL: `https://yourname.carrd.co`

**Time**: 10-15 minutes, no coding required

---

## 📝 **Option 4: Notion (Free)**

1. Go to [notion.so](https://notion.so)
2. Create a new page
3. Add your support content
4. Click **"Share"** → **"Publish to web"**
5. Get your public URL

---

## 🎨 **Ready-to-Use HTML Template**

Copy this into your `index.html` file (for GitHub Pages):

```html
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
            <p><strong>Email:</strong> <a href="mailto:your-email@example.com">your-email@example.com</a></p>
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
        <p>If you encounter any issues or bugs, please email us at <a href="mailto:your-email@example.com">your-email@example.com</a> with:</p>
        <ul>
            <li>Description of the issue</li>
            <li>Steps to reproduce (if possible)</li>
            <li>Your device model and iOS version</li>
        </ul>
        
        <h2>💡 Feature Requests</h2>
        <p>We'd love to hear your ideas! Send feature requests to <a href="mailto:your-email@example.com">your-email@example.com</a></p>
        
        <div class="footer">
            <p>Daily Verse Reading - Building daily Bible reading habits, one verse at a time.</p>
            <p>&copy; 2024 Daily Verse Reading. All rights reserved.</p>
        </div>
    </div>
</body>
</html>
```

**Remember to replace `your-email@example.com` with your actual email address!**

---

## ✅ Quick Checklist

- [ ] Choose a method (GitHub Pages recommended)
- [ ] Create the page
- [ ] Add your contact email
- [ ] Test the URL works
- [ ] Use the URL in App Store Connect

---

## 🎯 Recommendation

**Use GitHub Pages (Option 1)** because:
- ✅ Completely free
- ✅ Takes 5 minutes
- ✅ Professional URL
- ✅ Easy to update later
- ✅ No coding knowledge needed (just copy/paste)

Your support URL will be: `https://yourusername.github.io/dailyverse-support`

---

## 📝 Privacy Policy (Same Process)

You can create a `privacy.html` file in the same repository and link to it:
`https://yourusername.github.io/dailyverse-support/privacy.html`

Or create a separate repository: `dailyverse-privacy`

Both pages can be in the same repository - just create multiple HTML files!
