import 'package:flutter/material.dart';

class AppTextStyles {
  // Headline Styles
  static TextStyle get headline1 => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: Color(0xFF1A1A1A),
    height: 1.2,
    letterSpacing: -0.5,
  );

  static TextStyle get headline2 => const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Color(0xFF1A1A1A),
    height: 1.3,
    letterSpacing: -0.25,
  );

  static TextStyle get headline3 => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Color(0xFF1A1A1A),
    height: 1.3,
  );

  static TextStyle get headline4 => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Color(0xFF1A1A1A),
    height: 1.4,
  );

  // Body Styles
  static TextStyle get bodyLarge => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color(0xFF666666),
    height: 1.5,
  );

  static TextStyle get bodyMedium => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF666666),
    height: 1.5,
  );

  static TextStyle get bodySmall => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xFF999999),
    height: 1.4,
  );

  // Button Styles
  static TextStyle get buttonLarge => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.2,
    letterSpacing: 0.5,
  );

  static TextStyle get buttonMedium => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.25,
  );

  static TextStyle get buttonSmall =>
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 1.2);

  // Onboarding Specific Styles
  static TextStyle get onboardingTitle => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: Color(0xFF2563EB),
    height: 1.2,
    letterSpacing: -0.5,
  );

  static TextStyle get onboardingSubtitle => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Color(0xFF475569),
    height: 1.4,
  );

  static TextStyle get onboardingDescription => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color(0xFF64748B),
    height: 1.6,
  );

  // Label Styles
  static TextStyle get labelLarge => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xFF374151),
    height: 1.4,
  );

  static TextStyle get labelMedium => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xFF6B7280),
    height: 1.4,
  );

  static TextStyle get labelSmall => const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: Color(0xFF9CA3AF),
    height: 1.4,
  );
}
