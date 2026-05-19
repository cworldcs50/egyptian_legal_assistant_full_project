import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/failure.dart';
import 'package:flutter/material.dart' show BuildContext;

abstract class ISettingsRepository {
  Future<Either<Failure, void>> toggleNotifications(bool enable);
  Future<Either<Failure, void>> setTheme(bool isDark);
  Future<Either<Failure, void>> clearConversations();
  bool getNotificationsStatus();
  bool getThemeStatus(BuildContext context);
}
