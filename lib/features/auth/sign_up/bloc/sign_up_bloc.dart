import 'sign_up_event.dart';
import 'sign_up_state.dart';
import '../../models/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/i_auth_repository.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final IAuthRepository iAuthRepository;

  SignUpBloc({required this.iAuthRepository}) : super(SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());
    final result = await iAuthRepository.signUpWithEmailAndPassword(
      email: event.email,
      password: event.password,
      displayName: event.name,
    );
    result.fold((failure) => emit(SignUpFailure(failure.message)), (
      credential,
    ) async {
      final userModel = UserModel(
        userName: event.name,
        email: event.email,
        userId: credential.user!.uid,
      );
      emit(SignUpSuccess());
      await iAuthRepository.saveUserData(userModel: userModel);
      await iAuthRepository.setIsAuthorized(true);
    });
  }
}
