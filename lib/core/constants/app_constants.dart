class AppConstants {
  // App Info
  static const String appVersion = '1.0.0';
  static const String appName = 'Egyptian Legal Assistant';

  // Routes
  static const String splash = "/splash";
  static const String homeRoute = '/home';
  static const String lawsRoute = '/laws';
  static const String aboutRoute = '/about';
  static const String signInRoute = '/sign_in';
  static const String signUpRoute = '/sign_up';
  static const String sourcesRoute = '/sources';
  static const String settingsRoute = '/settings';
  static const String onboardingRoute = '/onboarding';
  static const String forgetPassword= "/forgetPassword";
  static const String previousChatsRoute = '/previous_chats';
  static const String chatbotRoute = '/chatbot';

  // Storage Keys
  static const String isFirstLaunchKey = 'is_first_launch';
  static const String userPreferencesKey = 'user_preferences';

  // UI Constants
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultPadding = 16.0;

  // Animation Durations
  static const Duration longAnimation = Duration(milliseconds: 600);
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
}
