import 'package:fpdart/fpdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/error/failure.dart';
import '../models/user_model.dart';

abstract class IAuthRepository {
  const IAuthRepository();

  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  });

  Future<Either<Failure, UserCredential>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName
  });

  Future<Either<Failure, UserCredential>> signInWithGoogle();

  Future<Either<Failure, UserCredential>> signInWithFacebook();

  Future<Either<Failure, void>> resetPassword({required String email});

  Future<Either<Failure, void>> logout();

  Future<void> saveUserData({required UserModel userModel});

  Future<void> setIsAuthorized(bool isAuthorized);

  bool getIsAuthorized();
}
