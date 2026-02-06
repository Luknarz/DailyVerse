#!/bin/bash
set -e

echo "📥 Fetching latest code..."
git fetch origin
git reset --hard origin/main

echo "🔨 Building for simulator..."
xcodebuild -project DailyVerse.xcodeproj \
  -scheme DailyVerse \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -configuration Debug \
  build

echo "📱 Starting simulator..."
open -a Simulator

echo "🚀 Installing and launching app..."
xcrun simctl boot "iPhone 15 Pro" 2>/dev/null || true
xcrun simctl install "iPhone 15 Pro" ~/Library/Developer/Xcode/DerivedData/DailyVerse-*/Build/Products/Debug-iphonesimulator/DailyVerse.app
xcrun simctl launch "iPhone 15 Pro" com.luknarz.dailyverse

echo "✅ Done! App running on simulator."
