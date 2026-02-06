#!/bin/bash

# Resize screenshots to App Store Connect required dimensions
# Usage: ./scripts/resize_screenshots.sh [screenshot_directory]

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Default directory
SCREENSHOT_DIR="${1:-DailyVerse_Screenshots/iPhone_15_Pro_Max_6.7}"

# Required dimensions for iPhone 6.7" (15 Pro Max)
REQUIRED_WIDTH=1284
REQUIRED_HEIGHT=2778

echo -e "${BLUE}📸 Screenshot Resizer for App Store Connect${NC}"
echo "=========================================="
echo ""

# Check if directory exists
if [ ! -d "$SCREENSHOT_DIR" ]; then
    echo -e "${RED}❌ Directory not found: $SCREENSHOT_DIR${NC}"
    exit 1
fi

# Check if sips is available
if ! command -v sips &> /dev/null; then
    echo -e "${RED}❌ sips command not found. This script requires macOS.${NC}"
    exit 1
fi

echo -e "${BLUE}Target directory: $SCREENSHOT_DIR${NC}"
echo -e "${BLUE}Required dimensions: ${REQUIRED_WIDTH} × ${REQUIRED_HEIGHT}px${NC}"
echo ""

# Count PNG files
PNG_COUNT=$(find "$SCREENSHOT_DIR" -maxdepth 1 -name "*.png" | wc -l | tr -d ' ')

if [ "$PNG_COUNT" -eq 0 ]; then
    echo -e "${RED}❌ No PNG files found in $SCREENSHOT_DIR${NC}"
    exit 1
fi

echo -e "${GREEN}Found $PNG_COUNT PNG file(s)${NC}"
echo ""

# Process each PNG file
RESIZED=0
SKIPPED=0

for file in "$SCREENSHOT_DIR"/*.png; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        
        # Get current dimensions
        CURRENT_WIDTH=$(sips -g pixelWidth "$file" | tail -1 | awk '{print $2}')
        CURRENT_HEIGHT=$(sips -g pixelHeight "$file" | tail -1 | awk '{print $2}')
        
        # Check if already correct size
        if [ "$CURRENT_WIDTH" -eq "$REQUIRED_WIDTH" ] && [ "$CURRENT_HEIGHT" -eq "$REQUIRED_HEIGHT" ]; then
            echo -e "${GREEN}✓${NC} $filename (already correct: ${CURRENT_WIDTH} × ${CURRENT_HEIGHT}px)"
            ((SKIPPED++))
        else
            echo -e "${YELLOW}Resizing${NC} $filename (${CURRENT_WIDTH} × ${CURRENT_HEIGHT}px → ${REQUIRED_WIDTH} × ${REQUIRED_HEIGHT}px)..."
            
            # Create temporary file
            TEMP_FILE="${file%.png}_resized.png"
            
            # Resize (sips -z takes height first, then width)
            sips -z "$REQUIRED_HEIGHT" "$REQUIRED_WIDTH" "$file" --out "$TEMP_FILE" > /dev/null
            
            # Replace original
            mv "$TEMP_FILE" "$file"
            
            # Verify
            NEW_WIDTH=$(sips -g pixelWidth "$file" | tail -1 | awk '{print $2}')
            NEW_HEIGHT=$(sips -g pixelHeight "$file" | tail -1 | awk '{print $2}')
            
            if [ "$NEW_WIDTH" -eq "$REQUIRED_WIDTH" ] && [ "$NEW_HEIGHT" -eq "$REQUIRED_HEIGHT" ]; then
                echo -e "${GREEN}✓${NC} $filename resized successfully"
                ((RESIZED++))
            else
                echo -e "${RED}❌ Error resizing $filename${NC}"
            fi
        fi
    fi
done

echo ""
echo -e "${GREEN}✅ Complete!${NC}"
echo "  Resized: $RESIZED"
echo "  Already correct: $SKIPPED"
echo ""
echo "Screenshots are now ready for App Store Connect upload."
