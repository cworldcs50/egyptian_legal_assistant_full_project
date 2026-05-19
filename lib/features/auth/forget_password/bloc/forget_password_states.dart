import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';

sealed class BaseForgetPasswordState extends Equatable {
  const BaseForgetPasswordState();
  @override
  List<Object?> get props => [];
}

class ForgetPasswordInitState extends BaseForgetPasswordState {}

class ForgetPasswordSuccessState extends BaseForgetPasswordState {}

class ForgetPasswordFailedState extends BaseForgetPasswordState {
  const ForgetPasswordFailedState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

class ForgetPasswordLoadingState extends BaseForgetPasswordState {}
