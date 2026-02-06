# Development Workflow

## Daily Development (Lukas)

```bash
./dev.sh
```
Das macht:
1. Pullt neuesten Code von GitHub
2. Baut die App
3. Startet Simulator
4. Installiert und startet App

## Release (wenn Herbot "Go" bekommt)

```bash
./release.sh
```
Das macht:
1. Pullt neuesten Code
2. Erstellt Release-Archive
3. Exportiert IPA
4. Lädt zu App Store Connect hoch

### Einmalige Setup für Release

1. **Team ID** in `ExportOptions.plist` eintragen
2. **App Store Connect API Key** erstellen:
   - https://appstoreconnect.apple.com/access/api
   - Key herunterladen (.p8 Datei)
3. **Environment Variables** setzen:
   ```bash
   export APP_STORE_API_KEY="XXXXXXXXXX"
   export APP_STORE_API_ISSUER="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
   ```

## Code-Änderungen

Herbot macht alle Code-Änderungen direkt auf GitHub.
Lukas testet nur und gibt "Go" für Release.
