import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool notificationsEnabled;
  final bool isDarkMode;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const SettingsState({
    this.notificationsEnabled = true,
    this.isDarkMode = false,
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  SettingsState copyWith({
    bool? notificationsEnabled,
    bool? isDarkMode,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [notificationsEnabled, isDarkMode, isLoading, errorMessage, isSuccess];
}
