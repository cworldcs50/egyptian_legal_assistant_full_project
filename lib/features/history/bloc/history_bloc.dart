import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/i_history_repository.dart';
import 'history_events.dart';
import 'history_states.dart';

class HistoryBloc extends Bloc<HistoryEvents, HistoryStates> {
  final IHistoryRepository iHistoryRepository;

  HistoryBloc({required this.iHistoryRepository}) : super(HistoryInitial()) {
    on<FetchSessionsEvent>(_onFetchSessions);
    on<DeleteSessionEvent>(_onDeleteSession);
  }

  Future<void> _onFetchSessions(
    FetchSessionsEvent event,
    Emitter<HistoryStates> emit,
  ) async {
    emit(HistoryLoading());
    final result = await iHistoryRepository.getAllSessions();
    result.fold(
      (failure) => emit(HistoryError(errorModel: failure)),
      (sessions) => emit(HistorySuccess(sessions: sessions)),
    );
  }

  Future<void> _onDeleteSession(
    DeleteSessionEvent event,
    Emitter<HistoryStates> emit,
  ) async {
    final result = await iHistoryRepository.deleteSession(event.sessionId);
    result.fold((failure) => emit(HistoryError(errorModel: failure)), (_) {
      emit(SessionDeleted());
      add(const FetchSessionsEvent());
    });
  }
}
