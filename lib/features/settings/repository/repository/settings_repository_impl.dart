import 'package:fpdart/fpdart.dart';
import 'i_settings_repository.dart';
import '../../../../../core/error/failure.dart';
import 'package:flutter/material.dart' show Theme;
import '../remote/i_settings_remote_data_source.dart';
import '../../../../../core/database/chat_history_db.dart';
import '../../../../../core/services/notification_service.dart';
import 'package:flutter/widgets.dart' show BuildContext, Brightness;
import '../../../../../core/shared_preference/shared_preference.dart';

class SettingsRepositoryImpl implements ISettingsRepository {
  final ISettingsRemoteDataSource remoteDataSource;

  SettingsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> toggleNotifications(bool enable) async {
    try {
      if (enable) {
        await NotificationService.instance.subscribeToTopic('allUsers');
      } else {
        await NotificationService.instance.unsubscribeFromTopic('allUsers');
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setTheme(bool isDark) async {
    try {
      final String themeValue = isDark ? 'dark' : 'light';
      await SharedPreference.sharedPreferencesInstance.setString(
        'app_theme_mode',
        themeValue,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearConversations() async {
    try {
      await ChatHistoryDatabase.instance.clearAllSessions();
      return await remoteDataSource.clearConversations();
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  bool getNotificationsStatus() {
    // This could be stored in SharedPreferences too if needed
    return true;
  }

  @override
  bool getThemeStatus(BuildContext context) {
    final String? savedTheme = SharedPreference.sharedPreferencesInstance
        .getString('app_theme_mode');

    if (savedTheme == null) {
      if (Theme.of(context).brightness == Brightness.dark) {
        return true;
      } else {
        return false;
      }
    }
    return savedTheme == 'dark';
  }
}
