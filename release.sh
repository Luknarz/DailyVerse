#!/bin/bash
set -e

# Config
SCHEME="DailyVerse"
PROJECT="DailyVerse.xcodeproj"
ARCHIVE_PATH="./build/DailyVerse.xcarchive"
EXPORT_PATH="./build/export"

echo "📥 Pulling latest code..."
git pull origin main

echo "🔨 Archiving for release..."
xcodebuild -project "$PROJECT" \
  -scheme "$SCHEME" \
  -configuration Release \
  -archivePath "$ARCHIVE_PATH" \
  archive

echo "📦 Exporting IPA..."
xcodebuild -exportArchive \
  -archivePath "$ARCHIVE_PATH" \
  -exportPath "$EXPORT_PATH" \
  -exportOptionsPlist ExportOptions.plist

echo "🚀 Uploading to App Store Connect..."
xcrun altool --upload-app \
  -f "$EXPORT_PATH/DailyVerse.ipa" \
  -t ios \
  --apiKey "$APP_STORE_API_KEY" \
  --apiIssuer "$APP_STORE_API_ISSUER"

echo "✅ Done! Check App Store Connect for the new build."
