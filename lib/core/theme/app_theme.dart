import 'package:flutter/material.dart';
import '../constants/app_dark_colors.dart';
import '../constants/app_light_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextTheme _buildTextTheme(Color textColor) {
    return GoogleFonts.cairoTextTheme().copyWith(
      displayMedium: GoogleFonts.cairo(
        height: 1.5,
        fontSize: 24,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: GoogleFonts.cairo(
        height: 1.5,
        fontSize: 20,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: GoogleFonts.cairo(
        height: 1.5,
        fontSize: 18,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: GoogleFonts.cairo(
        height: 1.5,
        fontSize: 16,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.cairo(
        height: 1.5,
        fontSize: 16,
        color: textColor,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: GoogleFonts.cairo(
        height: 1.5,
        fontSize: 16,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppLightColors.background,
      primaryColor: AppLightColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppLightColors.primary,
        onPrimary: AppLightColors.primaryForeground,
        secondary: AppLightColors.secondary,
        onSecondary: AppLightColors.secondaryForeground,
        surface: AppLightColors.card,
        onSurface: AppLightColors.cardForeground,
        error: AppLightColors.destructive,
        onError: AppLightColors.destructiveForeground,
      ),
      textTheme: _buildTextTheme(AppLightColors.foreground),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppLightColors.inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppLightColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppLightColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppLightColors.ring, width: 2),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppDarkColors.background,
      primaryColor: AppDarkColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppDarkColors.primary,
        onPrimary: AppDarkColors.primaryForeground,
        secondary: AppDarkColors.secondary,
        onSecondary: AppDarkColors.secondaryForeground,
        surface: AppDarkColors.card,
        onSurface: AppDarkColors.cardForeground,
        error: AppDarkColors.destructive,
        onError: AppDarkColors.destructiveForeground,
      ),
      textTheme: _buildTextTheme(AppDarkColors.foreground),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppDarkColors.inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppDarkColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppDarkColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppDarkColors.ring, width: 2),
        ),
      ),
    );
  }
}
