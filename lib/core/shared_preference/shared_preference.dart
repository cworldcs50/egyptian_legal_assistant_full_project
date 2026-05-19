import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static late SharedPreferences sharedPreferencesInstance;

  static Future<void> init() async {
    sharedPreferencesInstance = await SharedPreferences.getInstance();
  }
}
