#!/bin/bash
# Build and launch Daily Verse Reading in the iOS Simulator

set -e

cd "$(dirname "$0")"

SCHEME="Daily Verse Reading"
# Use iPhone 16 Pro if available, otherwise first available iPhone simulator
DESTINATION="platform=iOS Simulator,name=iPhone 16 Pro,OS=latest"

echo "Building and launching $SCHEME on simulator..."
xcodebuild \
  -scheme "$SCHEME" \
  -destination "$DESTINATION" \
  -configuration Debug \
  run
