import 'app_dark_colors.dart';
import 'app_light_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define the base text theme using Cairo
  static TextTheme _buildTextTheme(Color textColor) {
    return GoogleFonts.cairoTextTheme().copyWith(
      displayMedium: GoogleFonts.cairo(
        fontSize: 24, // text-2xl
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: textColor,
      ),
      displaySmall: GoogleFonts.cairo(
        fontSize: 20, // text-xl
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: textColor,
      ),
      headlineLarge: GoogleFonts.cairo(
        fontSize: 18, // text-lg
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: textColor,
      ),
      headlineMedium: GoogleFonts.cairo(
        fontSize: 16, // text-base
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: textColor,
      ),
      bodyLarge: GoogleFonts.cairo(
        fontSize: 16, // text-base
        fontWeight: FontWeight.w400, // font-weight-normal
        height: 1.5,
        color: textColor,
      ),
      labelLarge: GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: textColor,
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
      // Apply border outline everywhere as requested (@apply border-border outline-ring)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppLightColors.inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // var(--radius) -> 0.625rem
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
