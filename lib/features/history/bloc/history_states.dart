import 'package:equatable/equatable.dart';

import '../../../core/error/failure.dart';


abstract class HistoryStates extends Equatable {
  const HistoryStates();

  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryStates {}

class HistoryLoading extends HistoryStates {}

class HistorySuccess extends HistoryStates {
  final List<Map<String, dynamic>> sessions;
  const HistorySuccess({required this.sessions});

  @override
  List<Object?> get props => [sessions];
}

class HistoryError extends HistoryStates {
  final Failure errorModel;
  const HistoryError({required this.errorModel});

  @override
  List<Object?> get props => [errorModel];
}

class SessionDeleted extends HistoryStates {}
