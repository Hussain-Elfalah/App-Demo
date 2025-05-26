import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontHelper {
  /// Get IBM Plex font family based on language code
  static String getFontFamily(String languageCode) {
    return languageCode == 'ar' 
        ? GoogleFonts.ibmPlexSansArabic().fontFamily!
        : GoogleFonts.ibmPlexSans().fontFamily!;
  }

  /// Get IBM Plex TextStyle based on language code
  static TextStyle getTextStyle({
    required String languageCode,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
  }) {
    final fontFamily = getFontFamily(languageCode);
    
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  /// Get IBM Plex heading style
  static TextStyle getHeadingStyle({
    required String languageCode,
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.bold,
    Color color = Colors.white,
  }) {
    return getTextStyle(
      languageCode: languageCode,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  /// Get IBM Plex body style
  static TextStyle getBodyStyle({
    required String languageCode,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.white,
  }) {
    return getTextStyle(
      languageCode: languageCode,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  /// Get IBM Plex caption style
  static TextStyle getCaptionStyle({
    required String languageCode,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.grey,
  }) {
    return getTextStyle(
      languageCode: languageCode,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  /// Get IBM Plex button style
  static TextStyle getButtonStyle({
    required String languageCode,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
    Color color = Colors.white,
  }) {
    return getTextStyle(
      languageCode: languageCode,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
} 