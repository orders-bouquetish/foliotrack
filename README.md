# FolioTrack — Android App

Indian investment portfolio tracker, converted from HTML to full React Native / Expo app.

## Features

All 12 modules from the web app:
- **Portfolio Overview** — Net worth, asset allocation, P&L dashboard
- **Mutual Funds** — Holdings, SIP tracking, NAV, fund type filters
- **Stocks** — NSE/BSE holdings, P&L per stock
- **Bank Accounts** — Balance tracking, multi-bank
- **Fixed Deposits** — Maturity tracking, interest, countdown
- **Insurance Policies** — Life, Health, ULIP — coverage + premium due
- **Savings** — PPF, EPF, NPS, SSY with interest rates
- **Other Assets** — Gold, Real Estate, Silver, Crypto
- **Loans & Credit Cards** — EMI tracking, repayment progress, CC dues
- **Family Profiles** — Per-member portfolio breakdown
- **Reminders** — Payment due alerts with priority and overdue detection
- **Retirement Planner** — Corpus calculator with SIP projections

Additional Android features:
- Dark mode toggle (persisted)
- AsyncStorage persistence
- Slide-out drawer navigation
- Haptics-ready architecture

---

## Prerequisites

```bash
# Node.js 18+
node --version

# Install Expo CLI
npm install -g expo-cli eas-cli
```

---

## Setup

```bash
# 1. Install dependencies
cd FolioTrack
npm install

# 2. Start development server
npx expo start

# 3. Scan QR with Expo Go app on your Android phone
```

---

## Build APK (Android)

### Option A — EAS Build (recommended, free tier available)

```bash
# Login to Expo account
eas login

# Create Expo account at expo.dev if needed, then:
eas build:configure

# Build APK (installable on any Android)
eas build --platform android --profile preview

# Download APK from the EAS dashboard link printed in terminal
```

### Option B — Local build (requires Android Studio)

```bash
# Install Android Studio + SDK (API 33+)
# Set ANDROID_HOME env var

# Generate native project
npx expo run:android

# Or prebuild then build manually
npx expo prebuild --platform android
cd android && ./gradlew assembleRelease
# APK at: android/app/build/outputs/apk/release/app-release.apk
```

### Option C — Expo Go (instant, no build needed)

```bash
npx expo start
# Scan QR code with Expo Go app from Play Store
# Full app runs instantly — no APK needed for testing
```

---

## Project Structure

```
FolioTrack/
├── App.js                          # Entry point
├── app.json                        # Expo config
├── eas.json                        # EAS build profiles
├── src/
│   ├── context/
│   │   └── AppContext.js           # Global state, dark mode, AsyncStorage
│   ├── data/
│   │   └── sampleData.js           # Demo data (replace with your real data/API)
│   ├── navigation/
│   │   └── AppNavigator.js         # Drawer navigation + header
│   ├── screens/
│   │   ├── WealthScreen.js         # Dashboard
│   │   ├── MutualFundsScreen.js
│   │   ├── StocksScreen.js
│   │   ├── BanksScreen.js
│   │   ├── FDsScreen.js
│   │   ├── PoliciesScreen.js
│   │   ├── SavingsScreen.js
│   │   ├── OthersScreen.js
│   │   ├── LoansScreen.js
│   │   ├── ProfilesScreen.js
│   │   ├── RemindersScreen.js
│   │   └── RetirementScreen.js
│   ├── components/
│   │   └── UI.js                   # StatCard, SectionCard, Button, etc.
│   ├── theme/
│   │   └── index.js                # Colors, typography, spacing
│   └── utils/
│       └── formatters.js           # INR, pct, dates, retirement calc
```

---

## Connecting Real Data

Replace `src/data/sampleData.js` exports with API calls:

```javascript
// Example with MProfit or Zerodha API
export const fetchMutualFunds = async () => {
  const res = await fetch('https://your-api.com/mf');
  return res.json();
};
```

Then in `AppContext.js`, replace `useState(sampleData.mutualFunds)` with a `useEffect` that fetches live data.

---

## Customization

- Colors: `src/theme/index.js` — change `teal`, accent colors per module
- Add new modules: create a screen in `screens/`, add to `navItems` in `AppNavigator.js`
- Charts: replace simple progress bars with `victory-native` or `react-native-svg` charts (dependencies already in package.json)

---

## Tech Stack

| Layer | Library |
|-------|---------|
| Framework | React Native 0.74 |
| Build | Expo SDK 51 |
| Navigation | React Navigation 6 (Drawer) |
| Storage | AsyncStorage |
| Icons | @expo/vector-icons (Ionicons) |
| Build/Deploy | EAS Build |
