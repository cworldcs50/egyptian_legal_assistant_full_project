import 'settings_state.dart';
import 'settings_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/repository/i_settings_repository.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ISettingsRepository iSettingsRepository;

  SettingsBloc({required this.iSettingsRepository}) : super(const SettingsState()) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<ToggleNotificationsEvent>(_onToggleNotifications);
    on<ToggleThemeEvent>(_onToggleTheme);
    on<ClearConversationsEvent>(_onClearConversations);
  }

  void _onLoadSettings(LoadSettingsEvent event, Emitter<SettingsState> emit) {
    final notifications = iSettingsRepository.getNotificationsStatus();
    final isDark = iSettingsRepository.getThemeStatus(event.context);
    emit(state.copyWith(
      notificationsEnabled: notifications,
      isDarkMode: isDark,
    ));
  }

  Future<void> _onToggleNotifications(ToggleNotificationsEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await iSettingsRepository.toggleNotifications(event.enable);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) => emit(state.copyWith(isLoading: false, notificationsEnabled: event.enable)),
    );
  }

  Future<void> _onToggleTheme(ToggleThemeEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await iSettingsRepository.setTheme(event.isDark);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) => emit(state.copyWith(isLoading: false, isDarkMode: event.isDark)),
    );
  }

  Future<void> _onClearConversations(ClearConversationsEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await iSettingsRepository.clearConversations();
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }
}
