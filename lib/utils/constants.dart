import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Sixt Brand Colors
  static const Color primary = Color(0xFFF4811E); // Sixt Orange (Princeton Orange)
  static const Color secondary = Color(0xFF000000); // Sixt Black
  
  // Grayscale
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF8F8F8);
  static const Color mediumGray = Color(0xFFE5E5E5);
  static const Color darkGray = Color(0xFF666666);
  static const Color black = Color(0xFF000000);
  
  // Status Colors - Sixt themed
  static const Color success = Color(0xFFF4811E); // Sixt Orange for success
  static const Color warning = Color(0xFFFF9500); // Lighter orange for warnings
  static const Color error = Color(0xFFDC3545); // Red for errors
  static const Color info = Color(0xFF666666); // Gray for info
  
  // Rating Colors
  static const Color ratingGold = Color(0xFFF4811E); // Sixt Orange
  static const Color ratingSilver = Color(0xFF666666);
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.black,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.darkGray,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.darkGray,
  );
  
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  
  static const TextStyle buttonSecondary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

class AppBorderRadius {
  static const double small = 8.0;
  static const double medium = 12.0;
  static const double large = 16.0;
  static const double extraLarge = 24.0;
}

class AppConstants {
  // Demo Data
  static const String demoUserName = "Ahmed Al-Mansouri";
  static const String demoUserPhone = "+218 91 234 5678";
  static const String demoDriverName = "Omar";
  static const String demoDriverCar = "Toyota Camry";
  static const String demoDriverRating = "4.8";
  
  // Locations in Benghazi
  static const String currentLocationAddress = "شارع جمال عبد الناصر، بنغازي";
  static const String homeAddress = "حي الصابري، بنغازي";
  static const String workAddress = "المدينة الطبية، بنغازي";
  
  // Popular Places in Benghazi
  static const List<Map<String, String>> popularPlaces = [
    {
      'name': 'Benghazi Medical Center',
      'address': 'المدينة الطبية، بنغازي',
      'icon': 'local_hospital',
    },
    {
      'name': 'Benina Airport',
      'address': 'مطار بنينا الدولي، بنغازي',
      'icon': 'flight',
    },
    {
      'name': 'Al-Berka Shopping Center',
      'address': 'مركز البركة التجاري، بنغازي',
      'icon': 'shopping_bag',
    },
    {
      'name': 'University of Benghazi',
      'address': 'جامعة بنغازي، بنغازي',
      'icon': 'school',
    },
  ];
  
  // Ride Types
  static const List<Map<String, dynamic>> rideTypes = [
    {
      'name': 'UberX',
      'description': 'Affordable, everyday rides',
      'price': 15,
      'eta': 5,
      'icon': 'directions_car',
    },
    {
      'name': 'UberXL',
      'description': 'Larger vehicles for groups',
      'price': 22,
      'eta': 7,
      'icon': 'airport_shuttle',
    },
    {
      'name': 'Uber Black',
      'description': 'Premium rides with professional drivers',
      'price': 35,
      'eta': 8,
      'icon': 'local_taxi',
    },
  ];
  
  // Rating Options
  static const List<String> ratingOptions = [
    'Terrible',
    'Bad',
    'Okay',
    'Good',
    'Excellent',
  ];
  
  // Settings Menu Items
  static const List<Map<String, dynamic>> accountMenuItems = [
    {
      'title': 'Edit profile',
      'icon': Icons.person_outline,
      'route': '/edit-profile',
    },
    {
      'title': 'Notifications',
      'icon': Icons.notifications_outlined,
      'route': '/notifications',
    },
    {
      'title': 'Ride history',
      'icon': Icons.history,
      'route': '/ride-history',
    },
  ];
  
  static const List<Map<String, dynamic>> supportMenuItems = [
    {
      'title': 'Help',
      'icon': Icons.help_outline,
      'route': '/help',
    },
    {
      'title': 'Legal',
      'icon': Icons.description_outlined,
      'route': '/legal',
    },
  ];
  
  // Bottom Navigation
  static const List<Map<String, dynamic>> bottomNavItems = [
    {
      'label': 'Home',
      'icon': Icons.home_outlined,
      'activeIcon': Icons.home,
      'route': '/home',
    },
    {
      'label': 'Saved',
      'icon': Icons.bookmark_outline,
      'activeIcon': Icons.bookmark,
      'route': '/saved',
    },
    {
      'label': 'Go',
      'icon': Icons.location_on_outlined,
      'activeIcon': Icons.location_on,
      'route': '/where-to',
    },
    {
      'label': 'Activity',
      'icon': Icons.access_time_outlined,
      'activeIcon': Icons.access_time,
      'route': '/activity',
    },
  ];
} 