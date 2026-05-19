import '../constants/app_constants.dart';
import '../shared_preference/shared_preference.dart';

String getFirstRoute() {
  return SharedPreference.sharedPreferencesInstance.getBool('isFirstTime') ??
          true
      ? AppConstants.splash
      : SharedPreference.sharedPreferencesInstance.getBool('isAuthorized') ??
          false
      ? AppConstants.homeRoute
      : AppConstants.signInRoute;
}
