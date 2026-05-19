import 'package:flutter/material.dart';
import '../constants/app_light_colors.dart';
import '../constants/app_dark_colors.dart';

/// A dynamic accessor for the app's custom color palette that automatically
/// returns the right set of colors depending on the active ThemeMode.
class AppColors {
  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color subTitleColor(BuildContext context) =>
      _isDark(context) ? Colors.white : AppLightColors.accentForeground;

  static Color splashLogoColor(BuildContext context) =>
      _isDark(context) ? AppDarkColors.primary : AppLightColors.primary;

  static Color splashShadowColor(BuildContext context) =>
      _isDark(context)
          ? AppLightColors.primary.withValues(alpha: 0.5)
          : AppDarkColors.primary.withValues(alpha: 0.5);

  static Color pageIndicatorActiveColor(BuildContext context) =>
      _isDark(context) ? AppDarkColors.primary : AppLightColors.primary;
  static Color pageIndicatorInActiveColor(BuildContext context) =>
      _isDark(context)
          ? AppLightColors.primary.withValues(alpha: 0.5)
          : AppDarkColors.primary.withValues(alpha: 0.5);

  static Color ring(BuildContext context) =>
      _isDark(context) ? AppDarkColors.ring : AppLightColors.ring;
  static Color card(BuildContext context) =>
      _isDark(context) ? AppDarkColors.card : AppLightColors.card;
  static Color muted(BuildContext context) =>
      _isDark(context) ? AppDarkColors.muted : AppLightColors.muted;
  static Color border(BuildContext context) =>
      _isDark(context) ? AppDarkColors.border : AppLightColors.border;

  static Color primaryReverse(BuildContext context) =>
      _isDark(context) ? AppLightColors.primary : AppDarkColors.primary;

  static Color primary(BuildContext context) =>
      _isDark(context) ? AppDarkColors.primary : AppLightColors.primary;
  static Color foreground(BuildContext context) =>
      _isDark(context) ? AppDarkColors.foreground : AppLightColors.foreground;
  static Color background(BuildContext context) =>
      _isDark(context) ? AppDarkColors.background : AppLightColors.background;
  static Color destructive(BuildContext context) =>
      _isDark(context) ? AppDarkColors.destructive : AppLightColors.destructive;
  static Color cardForeground(BuildContext context) =>
      _isDark(context)
          ? AppDarkColors.cardForeground
          : AppLightColors.cardForeground;
  static Color mutedForeground(BuildContext context) =>
      _isDark(context)
          ? AppDarkColors.mutedForeground
          : AppLightColors.mutedForeground;
  static Color primaryForeground(BuildContext context) =>
      _isDark(context)
          ? AppDarkColors.primaryForeground
          : AppLightColors.primaryForeground;

  static Color error(BuildContext context) =>
      _isDark(context) ? AppDarkColors.error : AppLightColors.error;
}
