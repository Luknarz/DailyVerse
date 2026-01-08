#!/bin/bash

# DailyVerse Screenshot Creation Helper Script
# This script helps you prepare for taking screenshots

echo "📸 DailyVerse Screenshot Preparation Helper"
echo "=========================================="
echo ""

echo "This script will help you prepare your app for screenshots."
echo ""

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Xcode not found. Please install Xcode first."
    exit 1
fi

echo "✅ Xcode found"
echo ""

# Create screenshots directory
SCREENSHOTS_DIR="$HOME/Desktop/DailyVerse_Screenshots"
mkdir -p "$SCREENSHOTS_DIR/iPhone_15_Pro_Max_6.7"

echo "📁 Created directory: $SCREENSHOTS_DIR"
echo ""

echo "📋 Screenshot Checklist:"
echo "========================"
echo ""
echo "1. Home Screen with Verse"
echo "   - Open app"
echo "   - Ensure verse is displayed"
echo "   - Show streak indicator"
echo "   - Press Cmd+S in Simulator to save"
echo ""
echo "2. Reading History Calendar"
echo "   - Tap book icon in toolbar"
echo "   - Show calendar with filled days"
echo "   - Press Cmd+S to save"
echo ""
echo "3. Favorites View"
echo "   - Favorite a few verses first"
echo "   - Tap star icon in toolbar"
echo "   - Show favorite verses list"
echo "   - Press Cmd+S to save"
echo ""
echo "4. Settings Screen"
echo "   - Tap three dots menu"
echo "   - Tap 'App Settings'"
echo "   - Show all settings sections"
echo "   - Press Cmd+S to save"
echo ""
echo "5. Share Card (Optional)"
echo "   - Tap share button on a verse"
echo "   - Show share sheet with card"
echo "   - Press Cmd+S to save"
echo ""
echo "6. Multiple Verses (Optional)"
echo "   - Tap 'Read another verse' a few times"
echo "   - Show multiple verses"
echo "   - Press Cmd+S to save"
echo ""

echo "💡 Tips:"
echo "   - Use iPhone 15 Pro Max simulator (1290 x 2796 pixels)"
echo "   - Screenshots save to Desktop automatically"
echo "   - Move them to: $SCREENSHOTS_DIR/iPhone_15_Pro_Max_6.7/"
echo "   - Name them: 01_Home.png, 02_History.png, etc."
echo ""

echo "🚀 Ready to take screenshots!"
echo ""
echo "Next steps:"
echo "1. Open Xcode"
echo "2. Select iPhone 15 Pro Max simulator"
echo "3. Run your app (Cmd+R)"
echo "4. Follow the checklist above"
echo "5. Screenshots will save to Desktop"
echo "6. Move them to the screenshots directory"
echo ""

read -p "Press Enter to open the screenshots directory..."
open "$SCREENSHOTS_DIR"
