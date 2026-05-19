import 'sign_in_event.dart';
import 'sign_in_state.dart';
import '../../models/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/i_auth_repository.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final IAuthRepository iAuthRepository;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInBloc({required this.iAuthRepository}) : super(SignInInitial()) {
    on<SignInSubmitted>(_onSignInSubmitted);
    on<SignInWithGoogleRequested>(_onSignInWithGoogle);
    on<SignInWithFacebookRequested>(_onSignInWithFacebook);
  }

  Future<void> _onSignInSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoading());
    final result = await iAuthRepository.signInWithEmailAndPassword(
      email: event.email,
      password: event.password,
      displayName: event.name,
    );
    result.fold(
      (failure) => emit(SignInFailure(failure.message)),
      (credential) async {
        emit(SignInSuccess());
        await iAuthRepository.setIsAuthorized(true);
        await iAuthRepository.saveUserData(
          userModel: UserModel.fromFirebaseUser(credential.user!),
        );
      },
    );
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogleRequested event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoading());

    final result = await iAuthRepository.signInWithGoogle();
    result.fold(
      (failure) => emit(SignInFailure(failure.message)),
      (credential) async {
        emit(SignInSuccess());
        await iAuthRepository.setIsAuthorized(true);
        await iAuthRepository.saveUserData(
          userModel: UserModel.fromFirebaseUser(credential.user!),
        );
      },
    );
  }

  Future<void> _onSignInWithFacebook(
    SignInWithFacebookRequested event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoading());
    final result = await iAuthRepository.signInWithFacebook();
    result.fold(
      (failure) => emit(SignInFailure(failure.message)),
      (credential) async {
        emit(SignInSuccess());
        await iAuthRepository.setIsAuthorized(true);
        await iAuthRepository.saveUserData(
          userModel: UserModel.fromFirebaseUser(credential.user!),
        );
      },
    );
  }
}
