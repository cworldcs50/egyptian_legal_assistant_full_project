import 'theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared_preference/shared_preference.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeKey = 'app_theme_mode';

  ThemeCubit() : super(const ThemeState(themeMode: ThemeMode.system)) {
    _loadTheme();
  }

  void _loadTheme() {
    final String? savedTheme = SharedPreference.sharedPreferencesInstance
        .getString(_themeKey);
    if (savedTheme == 'dark') {
      emit(const ThemeState(themeMode: ThemeMode.dark));
    } else if (savedTheme == "light") {
      emit(const ThemeState(themeMode: ThemeMode.light));
    } else {
      emit(const ThemeState(themeMode: ThemeMode.system));
    }
  }

  Future<void> toggleTheme(bool isDark) async {
    final newMode = isDark ? ThemeMode.dark : ThemeMode.light;
    await SharedPreference.sharedPreferencesInstance.setString(
      _themeKey,
      isDark ? 'dark' : 'light',
    );
    emit(ThemeState(themeMode: newMode));
  }
}
