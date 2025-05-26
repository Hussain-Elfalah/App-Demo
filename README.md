# Uber-Like Demo App 🚗

A Flutter demo application that mimics core Uber functionality with a clean, modern UI.

## 🎯 Features

### Core Functionality
- **User Authentication** - Email/phone login and signup
- **Location Services** - Current location detection and address search
- **Ride Booking** - Select pickup and destination locations
- **Ride Summary** - View trip details, estimated cost and time
- **Driver Simulation** - Mock nearby drivers and ride acceptance
- **Rating System** - Rate drivers after ride completion
- **User Profile** - Manage account settings and ride history

### UI Screens (Based on Your Design)
1. **Where to?** - Location selection with search and saved places
2. **Ride Summary** - Trip details with map preview and pricing
3. **Rate Driver** - Post-ride rating and feedback system
4. **Settings** - User profile and app preferences

## 🛠️ Tech Stack

- **Frontend**: Flutter (Web + Mobile)
- **Backend**: Firebase
  - Authentication (Email/Phone)
  - Firestore Database
  - Cloud Functions
  - Hosting
- **Maps**: Google Maps Flutter Plugin
- **State Management**: Provider/Riverpod
- **UI**: Material Design 3

## 🚀 Quick Start

### Prerequisites
1. Flutter SDK (3.0+)
2. VS Code or Android Studio
3. Firebase account
4. Google Maps API key

### Installation
```bash
# Clone the repository
git clone <your-repo-url>
cd uber-demo-app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### For Web Demo
```bash
# Build for web
flutter build web

# Serve locally
flutter run -d chrome
```

## 🌐 Free Hosting Options

### 1. Firebase Hosting (Recommended)
- **Cost**: Free tier (10GB storage, 1GB transfer/month)
- **Custom Domain**: Yes
- **SSL**: Automatic
- **Setup**: `firebase deploy`

### 2. Vercel
- **Cost**: Free tier (100GB bandwidth/month)
- **Custom Domain**: Yes
- **Setup**: Connect GitHub repo

### 3. Netlify
- **Cost**: Free tier (100GB bandwidth/month)
- **Custom Domain**: Yes
- **Setup**: Drag & drop build folder

## 📱 Demo Links

- **Web Demo**: [Your hosted URL here]
- **APK Download**: [Android APK link]
- **TestFlight**: [iOS TestFlight link]

## 🎨 Design Preview

The app follows your provided design mockups with:
- Clean, minimal interface
- Intuitive navigation
- Modern Material Design components
- Responsive layout for all screen sizes

## 📋 Project Structure

```
lib/
├── main.dart
├── models/
│   ├── user.dart
│   ├── ride.dart
│   └── driver.dart
├── screens/
│   ├── auth/
│   ├── home/
│   ├── booking/
│   ├── rating/
│   └── settings/
├── widgets/
│   ├── common/
│   └── custom/
├── services/
│   ├── auth_service.dart
│   ├── location_service.dart
│   └── ride_service.dart
└── utils/
    ├── constants.dart
    └── helpers.dart
```

## 🔧 Configuration

### Firebase Setup
1. Create Firebase project
2. Enable Authentication, Firestore, Hosting
3. Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
4. Add configuration files to respective platform folders

### Google Maps Setup
1. Enable Maps SDK for Android/iOS/Web
2. Add API key to `android/app/src/main/AndroidManifest.xml`
3. Add API key to `ios/Runner/AppDelegate.swift`
4. Add API key to `web/index.html`

## 📊 Customer Feedback

Share this demo with your customers:
1. **Web Link**: Instant access, no installation required
2. **QR Code**: Easy mobile access
3. **Feedback Form**: Collect ratings and suggestions

## 🚀 Deployment Commands

```bash
# Build for web
flutter build web --release

# Deploy to Firebase
firebase deploy

# Build Android APK
flutter build apk --release

# Build iOS (macOS only)
flutter build ios --release
```

## 📞 Support

For questions or issues:
- Email: [your-email]
- GitHub Issues: [repo-issues-url]
- Documentation: [docs-url]

---

**Built with ❤️ using Flutter** 