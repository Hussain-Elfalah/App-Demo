# Google Maps API Setup for Benghazi Uber Demo

## Overview
The app now uses real Google Maps to display Benghazi with accurate street layouts, landmarks, and navigation. This provides a much more realistic experience compared to the custom painted maps.

## ⚠️ IMPORTANT: API Key Required
The app currently shows an `InvalidKeyMapError` because it's using a placeholder API key. You need to get a real Google Maps API key to make the maps work.

## Quick Setup Guide

### Step 1: Create Google Cloud Project
1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Sign in with your Google account
3. Click "Select a project" → "New Project"
4. Enter project name (e.g., "Benghazi Uber Demo")
5. Click "Create"

### Step 2: Enable Billing
1. Go to [Billing page](https://console.cloud.google.com/billing)
2. Click "Link a billing account" or "Create account"
3. Add payment method (you get $200 free credit monthly)
4. **Note**: For demo apps, you likely won't exceed the free tier

### Step 3: Enable Maps JavaScript API
1. Go to [APIs & Services](https://console.cloud.google.com/apis/dashboard)
2. Click "+ ENABLE APIS AND SERVICES"
3. Search for "Maps JavaScript API"
4. Click on it and click "Enable"

### Step 4: Create API Key
1. Go to [Credentials page](https://console.cloud.google.com/apis/credentials)
2. Click "+ CREATE CREDENTIALS" → "API key"
3. Copy the API key that appears
4. Click "RESTRICT KEY" (recommended for security)

### Step 5: Restrict API Key (Security)
1. Under "Application restrictions", select "HTTP referrers (web sites)"
2. Click "ADD AN ITEM" and add:
   - `localhost:*/*` (for development)
   - `yourdomain.com/*` (for production)
3. Under "API restrictions", select "Restrict key"
4. Choose "Maps JavaScript API"
5. Click "Save"

### Step 6: Update Your App
Replace the placeholder in `web/index.html`:

**Current (line 35):**
```html
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"></script>
```

**Replace with:**
```html
<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_ACTUAL_API_KEY_HERE"></script>
```

## Features with Google Maps API
- **Real Benghazi Map**: Actual street layout and geography
- **Landmark Markers**: Medical Center, Airport, University, Shopping Centers
- **Route Visualization**: Pickup and destination markers with route planning
- **Black & White Theme**: Custom map styling to match the app's monochromatic design
- **Interactive Maps**: Zoom, pan, and explore real Benghazi locations

## Benghazi Locations Included

### Coordinates Used
- **City Center**: 32.1165°N, 20.0686°E
- **Medical Center**: 32.1089°N, 20.0642°E  
- **Benina Airport**: 32.0968°N, 20.2695°E
- **University**: 32.1147°N, 20.0764°E
- **Sabri District**: 32.1203°N, 20.0589°E

### Map Features
- Custom black and white styling
- Major roads highlighted
- Mediterranean coastline visible
- Important landmarks marked
- Route planning between locations

## Cost Considerations

### Free Tier (More than enough for demos)
Google Maps provides:
- **$200 monthly credit** (covers ~28,000 map loads)
- **40,000 geocoding requests per month** (free)
- **100,000 static map requests per month** (free)

### For Demo Apps
The free tier is more than sufficient for:
- Customer demonstrations
- Development and testing
- Small-scale deployments
- Personal projects

## Alternative Options

### Option 1: Temporary Fix (Remove Google Maps)
If you want to get the app running immediately without an API key, you can temporarily disable Google Maps and use the custom painted maps instead.

### Option 2: Other Map Providers
- **OpenStreetMap** (completely free)
- **Mapbox** (has free tier)
- **Apple Maps** (iOS only)

## Deployment Notes

### Free Hosting Platforms
All mentioned hosting platforms support Google Maps:
- ✅ Firebase Hosting (Google's own platform)
- ✅ Vercel
- ✅ Netlify  
- ✅ GitHub Pages

### Security Best Practices
- Always restrict your API key to specific domains
- Never commit API keys to public repositories
- Use environment variables for production deployments
- Set up billing alerts to avoid unexpected charges

## Testing After Setup
1. Replace the API key in `web/index.html`
2. Run: `flutter run -d chrome --web-port=8080`
3. Navigate through the booking flow
4. Check that maps load with Benghazi locations
5. Verify the black and white styling is applied
6. Test route visualization in ride summary

## Troubleshooting

### Common Issues
- **"For development purposes only" watermark**: Billing not enabled
- **Gray map**: API key restrictions too strict
- **No map at all**: API key invalid or Maps JavaScript API not enabled

### Quick Fixes
- Check browser console for specific error messages
- Verify API key is correctly copied (no extra spaces)
- Ensure Maps JavaScript API is enabled in Google Cloud Console
- Check that billing is set up (even for free tier)

The app will provide a professional, realistic mapping experience once the API key is properly configured! 🗺️ 