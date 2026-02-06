#!/bin/bash

# Verify Info.plist has required keys for App Store submission
# Usage: ./scripts/verify_info_plist.sh [Info.plist path]

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Default Info.plist path
INFO_PLIST="${1:-DailyVerse/Info.plist}"

echo -e "${BLUE}🔍 Info.plist Verification${NC}"
echo "=============================="
echo ""

# Check if file exists
if [ ! -f "$INFO_PLIST" ]; then
    echo -e "${RED}❌ Info.plist not found: $INFO_PLIST${NC}"
    exit 1
fi

echo -e "${BLUE}Checking: $INFO_PLIST${NC}"
echo ""

# Check for export compliance key
if grep -q "ITSAppUsesNonExemptEncryption" "$INFO_PLIST"; then
    VALUE=$(grep -A1 "ITSAppUsesNonExemptEncryption" "$INFO_PLIST" | grep -E "(true|false)" | sed 's/.*<\(.*\)>.*/\1/')
    if [ "$VALUE" = "false" ]; then
        echo -e "${GREEN}✓${NC} Export compliance key present and set to false"
    else
        echo -e "${YELLOW}⚠️${NC}  Export compliance key present but set to $VALUE (should be false)"
    fi
else
    echo -e "${RED}❌${NC} Export compliance key missing!"
    echo "   Add to Info.plist:"
    echo "   <key>ITSAppUsesNonExemptEncryption</key>"
    echo "   <false/>"
fi

# Check for bundle identifier
if grep -q "CFBundleIdentifier" "$INFO_PLIST"; then
    echo -e "${GREEN}✓${NC} Bundle identifier present"
else
    echo -e "${YELLOW}⚠️${NC}  Bundle identifier not found in Info.plist (may be in project settings)"
fi

# Check for version
if grep -q "CFBundleShortVersionString" "$INFO_PLIST"; then
    VERSION=$(grep -A1 "CFBundleShortVersionString" "$INFO_PLIST" | grep string | sed 's/.*<string>\(.*\)<\/string>.*/\1/')
    echo -e "${GREEN}✓${NC} Version: $VERSION"
else
    echo -e "${YELLOW}⚠️${NC}  Version not found"
fi

# Check for build number
if grep -q "CFBundleVersion" "$INFO_PLIST"; then
    BUILD=$(grep -A1 "CFBundleVersion" "$INFO_PLIST" | grep string | sed 's/.*<string>\(.*\)<\/string>.*/\1/')
    echo -e "${GREEN}✓${NC} Build: $BUILD"
else
    echo -e "${YELLOW}⚠️${NC}  Build number not found"
fi

echo ""
echo -e "${BLUE}Verification complete!${NC}"
