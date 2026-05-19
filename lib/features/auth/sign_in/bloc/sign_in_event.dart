import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInSubmitted extends SignInEvent {
  final String email;
  final String password;
  final String name;

  const SignInSubmitted({
    required this.email,
    required this.name,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SignInWithGoogleRequested extends SignInEvent {
  const SignInWithGoogleRequested();
}

class SignInWithFacebookRequested extends SignInEvent {
  const SignInWithFacebookRequested();
}
