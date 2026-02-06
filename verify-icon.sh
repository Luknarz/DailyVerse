#!/bin/bash

# Quick script to verify app icon requirements

ICON_PATH="DailyVerse/Resources/Assets.xcassets/AppIcon.appiconset/Icon-marketing.png"

echo "🔍 Checking App Icon Requirements..."
echo ""

if [ ! -f "$ICON_PATH" ]; then
    echo "❌ Icon file not found at: $ICON_PATH"
    exit 1
fi

echo "✅ Icon file exists"

# Check dimensions
DIMENSIONS=$(sips -g pixelWidth -g pixelHeight "$ICON_PATH" 2>/dev/null | grep -E "pixelWidth|pixelHeight" | awk '{print $2}')
WIDTH=$(echo "$DIMENSIONS" | head -1)
HEIGHT=$(echo "$DIMENSIONS" | tail -1)

echo "📐 Dimensions: ${WIDTH}x${HEIGHT}"

if [ "$WIDTH" = "1024" ] && [ "$HEIGHT" = "1024" ]; then
    echo "✅ Correct size (1024x1024)"
else
    echo "❌ Wrong size! Must be exactly 1024x1024"
fi

# Check format
FILE_TYPE=$(file "$ICON_PATH")
if echo "$FILE_TYPE" | grep -q "PNG"; then
    echo "✅ PNG format"
else
    echo "❌ Not PNG format"
fi

# Check for transparency (RGBA vs RGB)
if echo "$FILE_TYPE" | grep -q "RGBA"; then
    echo "⚠️  RGBA format detected (may have transparency)"
    echo "   Note: RGBA is okay if background is solid"
    echo "   To verify: Open in Preview and check for checkerboard pattern"
else
    echo "✅ RGB format (no transparency)"
fi

echo ""
echo "📋 Summary:"
echo "   - Size: ${WIDTH}x${HEIGHT}"
echo "   - Format: PNG"
echo "   - Transparency: Check manually in Preview"
echo ""
echo "💡 To check transparency:"
echo "   1. Open icon in Preview"
echo "   2. Look for checkerboard pattern = has transparency ❌"
echo "   3. Solid background = no transparency ✅"
