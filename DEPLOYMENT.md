# Deployment Guide 🚀

This guide will help you deploy your Uber-like demo app to various free hosting platforms.

## 📋 Prerequisites

Before deploying, make sure you have:
- Flutter SDK installed and working
- Firebase project set up (optional but recommended)
- Git repository for your code

## 🌐 Web Deployment

### Option 1: Firebase Hosting (Recommended)

Firebase Hosting is perfect for Flutter web apps and offers:
- **Free tier**: 10GB storage, 1GB transfer/month
- **Custom domain support**
- **Automatic SSL certificates**
- **Global CDN**

#### Setup Steps:

1. **Install Firebase CLI**
   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase**
   ```bash
   firebase login
   ```

3. **Initialize Firebase in your project**
   ```bash
   firebase init hosting
   ```
   - Select your Firebase project
   - Set public directory to `build/web`
   - Configure as single-page app: Yes
   - Don't overwrite index.html

4. **Build your Flutter web app**
   ```bash
   flutter build web --release
   ```

5. **Deploy to Firebase**
   ```bash
   firebase deploy
   ```

6. **Your app will be live at**: `https://your-project-id.web.app`

#### Firebase Configuration

Update `lib/main.dart` with your Firebase config:
```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "your-api-key",
    authDomain: "your-project.firebaseapp.com",
    projectId: "your-project-id",
    storageBucket: "your-project.appspot.com",
    messagingSenderId: "123456789",
    appId: "1:123456789:web:abcdef123456",
  ),
);
```

### Option 2: Vercel

Vercel offers excellent performance and is developer-friendly:
- **Free tier**: 100GB bandwidth/month
- **Automatic deployments from Git**
- **Custom domains**

#### Setup Steps:

1. **Build your app**
   ```bash
   flutter build web --release
   ```

2. **Install Vercel CLI**
   ```bash
   npm install -g vercel
   ```

3. **Deploy**
   ```bash
   cd build/web
   vercel
   ```

4. **Or connect your GitHub repo** at [vercel.com](https://vercel.com)

### Option 3: Netlify

Great for static sites with drag-and-drop deployment:
- **Free tier**: 100GB bandwidth/month
- **Form handling**
- **Serverless functions**

#### Setup Steps:

1. **Build your app**
   ```bash
   flutter build web --release
   ```

2. **Deploy via drag-and-drop**
   - Go to [netlify.com](https://netlify.com)
   - Drag the `build/web` folder to the deploy area

3. **Or connect your Git repository** for automatic deployments

### Option 4: GitHub Pages

Free hosting directly from your GitHub repository:

#### Setup Steps:

1. **Build your app**
   ```bash
   flutter build web --release --base-href "/your-repo-name/"
   ```

2. **Copy build files to docs folder**
   ```bash
   cp -r build/web/* docs/
   ```

3. **Commit and push**
   ```bash
   git add .
   git commit -m "Deploy to GitHub Pages"
   git push
   ```

4. **Enable GitHub Pages**
   - Go to repository Settings > Pages
   - Select source: Deploy from a branch
   - Branch: main, folder: /docs

## 📱 Mobile Deployment

### Android APK

Build a release APK for testing:

```bash
flutter build apk --release
```

The APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

### iOS (macOS only)

Build for iOS:

```bash
flutter build ios --release
```

## 🔧 Environment Configuration

### For Production Deployment

1. **Update Firebase configuration** in `lib/main.dart`
2. **Add Google Maps API keys** (if using maps):
   - Android: `android/app/src/main/AndroidManifest.xml`
   - iOS: `ios/Runner/AppDelegate.swift`
   - Web: `web/index.html`

3. **Update app metadata**:
   - App name in `pubspec.yaml`
   - Bundle ID for iOS
   - Package name for Android

### Environment Variables

For sensitive data, use environment variables:

```dart
// lib/config/environment.dart
class Environment {
  static const String firebaseApiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const String mapsApiKey = String.fromEnvironment('MAPS_API_KEY');
}
```

Build with environment variables:
```bash
flutter build web --dart-define=FIREBASE_API_KEY=your_key --dart-define=MAPS_API_KEY=your_key
```

## 🎯 Optimization Tips

### Performance Optimization

1. **Enable web renderers**
   ```bash
   flutter build web --web-renderer canvaskit --release
   ```

2. **Optimize images**
   - Use WebP format for web
   - Compress images
   - Use appropriate sizes

3. **Code splitting**
   ```bash
   flutter build web --split-per-route --release
   ```

### SEO Optimization

Add to `web/index.html`:
```html
<meta name="description" content="Uber-like demo app built with Flutter">
<meta name="keywords" content="uber, demo, flutter, ride sharing">
<meta property="og:title" content="Uber Demo App">
<meta property="og:description" content="Experience our Uber-like demo application">
```

## 📊 Analytics & Monitoring

### Google Analytics

Add to `web/index.html`:
```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_TRACKING_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_TRACKING_ID');
</script>
```

### Firebase Analytics

Add to your Flutter app:
```dart
import 'package:firebase_analytics/firebase_analytics.dart';

final analytics = FirebaseAnalytics.instance;
await analytics.logEvent(name: 'ride_requested');
```

## 🔒 Security Considerations

1. **API Key Security**
   - Restrict API keys to specific domains
   - Use environment variables
   - Don't commit sensitive data

2. **Firebase Security Rules**
   ```javascript
   // Firestore rules
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /users/{userId} {
         allow read, write: if request.auth != null && request.auth.uid == userId;
       }
     }
   }
   ```

## 📈 Monitoring & Updates

### Continuous Deployment

Set up GitHub Actions for automatic deployment:

```yaml
# .github/workflows/deploy.yml
name: Deploy to Firebase
on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: subosito/flutter-action@v2
    - run: flutter build web --release
    - uses: FirebaseExtended/action-hosting-deploy@v0
      with:
        repoToken: '${{ secrets.GITHUB_TOKEN }}'
        firebaseServiceAccount: '${{ secrets.FIREBASE_SERVICE_ACCOUNT }}'
        projectId: your-project-id
```

### Performance Monitoring

Use Firebase Performance Monitoring:
```dart
import 'package:firebase_performance/firebase_performance.dart';

final trace = FirebasePerformance.instance.newTrace('ride_booking');
await trace.start();
// Your code here
await trace.stop();
```

## 🎉 Go Live Checklist

- [ ] Firebase project configured
- [ ] API keys added and restricted
- [ ] App built for production
- [ ] Domain configured (if using custom domain)
- [ ] Analytics set up
- [ ] Performance monitoring enabled
- [ ] Security rules configured
- [ ] SSL certificate active
- [ ] App tested on multiple devices/browsers

## 📞 Support

If you encounter issues:
1. Check the [Flutter web deployment docs](https://docs.flutter.dev/deployment/web)
2. Review platform-specific documentation
3. Check browser console for errors
4. Test on different browsers and devices

---

**Your app is now ready to impress customers! 🚀** 