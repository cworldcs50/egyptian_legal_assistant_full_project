import 'dart:async';
import 'forget_password_events.dart';
import 'forget_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/i_auth_repository.dart';

class ForgetPasswordBloc
    extends Bloc<BaseForgetPasswordEvent, BaseForgetPasswordState> {
  final IAuthRepository iAuthRepository;
  final TextEditingController emailController = TextEditingController();

  ForgetPasswordBloc({required this.iAuthRepository})
    : super(ForgetPasswordInitState()) {
    on<ForgetPasswordEvent>(_getEmail);
  }

  Future<void> _getEmail(ForgetPasswordEvent event, emit) async {
    emit(ForgetPasswordLoadingState());
    final result = await iAuthRepository.resetPassword(email: event.userEmail);

    result.fold(
      (failure) => emit(ForgetPasswordFailedState(failure: failure)),
      (_) => emit(ForgetPasswordSuccessState()),
    );
  }
}
