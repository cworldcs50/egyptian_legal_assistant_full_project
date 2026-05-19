import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/cubit/theme_cubit.dart';
import 'core/theme/cubit/theme_state.dart';
import 'core/services/service_locator.dart';
import 'core/functions/get_first_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class EgyptianLegalAssistant extends StatelessWidget {
  const EgyptianLegalAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            themeMode: state.themeMode,
            theme: AppTheme.lightTheme,
            title: AppConstants.appName,
            darkTheme: AppTheme.darkTheme,
            locale: const Locale('ar', 'EG'),
            initialRoute: getFirstRoute(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            onGenerateRoute: AppRouter.generateRoute,
            supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'US')],
          );
        },
      ),
    );
  }
}
