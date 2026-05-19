import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show BuildContext;

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class ToggleNotificationsEvent extends SettingsEvent {
  final bool enable;
  const ToggleNotificationsEvent(this.enable);

  @override
  List<Object?> get props => [enable];
}

class ToggleThemeEvent extends SettingsEvent {
  final bool isDark;
  const ToggleThemeEvent(this.isDark);

  @override
  List<Object?> get props => [isDark];
}

class ClearConversationsEvent extends SettingsEvent {}

class LoadSettingsEvent extends SettingsEvent {
  final BuildContext context;
  const LoadSettingsEvent(this.context);
  @override
  List<Object?> get props => [context];
}
