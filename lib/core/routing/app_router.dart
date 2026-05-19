import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/about/view/about_view.dart';
import '../../features/auth/forget_password/view/forget_password.dart';
import '../../features/auth/sign_in/view/sign_in.dart';
import '../../features/auth/sign_up/view/sign_up.dart';
import '../../features/history/view/history_view.dart';
import '../../features/settings/view/settings_view.dart';
import '../../features/sources/view/sources_view.dart';
import '../constants/app_constants.dart';
import '../services/service_locator.dart';
import '../../features/home/home/view/home_view.dart';
import '../../features/home/home/bloc/home_bloc.dart';
import '../../features/splash/view/splash.dart';
import '../../features/onboarding/view/onboarding_view.dart';
// import '../../features/chatbot/view/chatbot_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.splash:
        return MaterialPageRoute(builder: (_) => const Splash());
      case AppConstants.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case AppConstants.signInRoute:
        return MaterialPageRoute(builder: (_) => const SignInView());
      case AppConstants.signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case AppConstants.previousChatsRoute:
        // Provide the singleton HomeBloc so HistoryView can trigger LoadSessionEvent
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: sl<HomeBloc>(),
            child: const HistoryView(),
          ),
        );
      case AppConstants.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case AppConstants.aboutRoute:
        return MaterialPageRoute(builder: (_) => const AboutView());
      case AppConstants.settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case AppConstants.sourcesRoute:
        return MaterialPageRoute(builder: (_) => const SourcesView());
      case AppConstants.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPassword());
      // case AppConstants.chatbotRoute:
      //   return MaterialPageRoute(builder: (_) => const ChatbotView());
      default:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
    }
  }
}
