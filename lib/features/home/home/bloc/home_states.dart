import 'package:equatable/equatable.dart';
import '../../../../core/classes/error_model.dart';
import '../../chatbot/models/chat_message_model.dart';

class HomeStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitHomeState extends HomeStates {
  final String welcomeMessage;

  InitHomeState({required this.welcomeMessage});

  @override
  List<Object?> get props => [welcomeMessage];
}

class LoadingHomeState extends HomeStates {}

class SuccessHomeState extends HomeStates {
  final List<ChatMessage> messages;
  SuccessHomeState({required this.messages});

  @override
  List<Object?> get props => [messages, DateTime.now().millisecondsSinceEpoch]; // Force rebuild
}

class FailureSignOutState extends HomeStates {
  final ErrorModel errorModel;

  FailureSignOutState({required this.errorModel});

  @override
  List<Object?> get props => [errorModel];
}

class SuccessSignOut extends HomeStates {}

class ErrorHomeState extends HomeStates {
  final ErrorModel errorModel;

  ErrorHomeState({required this.errorModel});

  @override
  List<Object?> get props => [errorModel];
}

class ChatTextChangedState extends HomeStates {
  final bool hasText;
  ChatTextChangedState(this.hasText);

  @override
  List<Object?> get props => [hasText];
}
