import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/booking/where_to_screen.dart';
import 'screens/booking/choose_driver_screen.dart';
import 'screens/booking/ride_summary_screen.dart';
import 'screens/rating/rating_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'services/language_service.dart';
import 'utils/constants.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageService(),
      child: const UberDemoApp(),
    ),
  );
}

class UberDemoApp extends StatelessWidget {
  const UberDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        // Choose IBM Plex font based on language
        final isArabic = languageService.currentLocale.languageCode == 'ar';
        final textTheme = isArabic 
          ? GoogleFonts.ibmPlexSansArabicTextTheme(ThemeData.dark().textTheme)
          : GoogleFonts.ibmPlexSansTextTheme(ThemeData.dark().textTheme);
        
        return MaterialApp(
          title: 'Sixt Benghazi Demo',
          debugShowCheckedModeBanner: false,
          locale: languageService.currentLocale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: AppColors.primary, // Sixt Orange
          secondary: AppColors.primary,
          surface: const Color(0xFF1A1A1A), // Dark surface
          background: const Color(0xFF121212), // Dark background
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onBackground: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        textTheme: textTheme.copyWith(
          headlineLarge: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
            fontFamily: isArabic ? GoogleFonts.ibmPlexSansArabic().fontFamily : GoogleFonts.ibmPlexSans().fontFamily,
          ),
          headlineMedium: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
            fontFamily: isArabic ? GoogleFonts.ibmPlexSansArabic().fontFamily : GoogleFonts.ibmPlexSans().fontFamily,
          ),
          headlineSmall: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.w600,
            fontFamily: isArabic ? GoogleFonts.ibmPlexSansArabic().fontFamily : GoogleFonts.ibmPlexSans().fontFamily,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontFamily: isArabic ? GoogleFonts.ibmPlexSansArabic().fontFamily : GoogleFonts.ibmPlexSans().fontFamily,
          ),
          bodyMedium: TextStyle(
            color: Colors.grey,
            fontFamily: isArabic ? GoogleFonts.ibmPlexSansArabic().fontFamily : GoogleFonts.ibmPlexSans().fontFamily,
          ),
          bodySmall: TextStyle(
            color: Colors.grey,
            fontFamily: isArabic ? GoogleFonts.ibmPlexSansArabic().fontFamily : GoogleFonts.ibmPlexSans().fontFamily,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2A2A2A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        cardTheme: const CardThemeData(
          color: Color(0xFF1A1A1A),
          elevation: 4,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1A1A1A),
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: const HomeScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/where-to': (context) => const WhereToScreen(),
        '/choose-driver': (context) => const ChooseDriverScreen(),
        '/ride-summary': (context) => const RideSummaryScreen(),
        '/rating': (context) => const RatingScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
      },
    );
  }
}

 