import 'package:fpdart/fpdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/firebase_services.dart';
import '../../../../core/shared_preference/shared_preference.dart';
import '../../../../core/classes/error_model.dart';
import '../../models/user_model.dart';
import 'i_auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  final FirebaseService firebaseService;

  const AuthRemoteDataSourceImpl({required this.firebaseService});

  // Helper to map ErrorModel to Failure
  Either<Failure, T> _mapErrorToFailure<T>(Either<ErrorModel, T> result) {
    return result.fold((error) {
      if (error.message.contains('Internet')) {
        return Left(NetworkFailure(message: error.message));
      }
      return Left(AuthFailure(message: error.message));
    }, (success) => Right(success));
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final result = await firebaseService.signInWithEmailAndPassword(
      email: email,
      password: password,
      displayName: displayName,
    );
    return _mapErrorToFailure(result);
  }

  @override
  Future<Either<Failure, UserCredential>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final result = await firebaseService.signUpWithEmailAndPassword(
      email: email,
      password: password,
      displayName: displayName,
    );
    return _mapErrorToFailure(result);
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    final result = await firebaseService.signInWithGoogle();
    return _mapErrorToFailure(result);
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithFacebook() async {
    final result = await firebaseService.signInWithFacebook();
    return _mapErrorToFailure(result);
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    final result = await firebaseService.resetPassword(email);
    return _mapErrorToFailure(result);
  }

  @override
  Future<Either<Failure, void>> logout() async {
    final result = await firebaseService.logout();
    return _mapErrorToFailure(result);
  }

  @override
  Future<void> saveUserData({required UserModel userModel}) async {
    if (userModel.email.trim().isNotEmpty) {
      await SharedPreference.sharedPreferencesInstance.setString(
        "userEmail",
        userModel.email,
      );
    }

    await SharedPreference.sharedPreferencesInstance.setString(
      "userId",
      userModel.userId,
    );

    if (userModel.userName.trim().isNotEmpty) {
      await SharedPreference.sharedPreferencesInstance.setString(
        "userName",
        userModel.userName,
      );
    }
  }

  @override
  Future<void> setIsAuthorized(bool isAuthorized) async {
    await SharedPreference.sharedPreferencesInstance.setBool(
      'isAuthorized',
      isAuthorized,
    );
  }

  @override
  bool getIsAuthorized() {
    return SharedPreference.sharedPreferencesInstance.getBool('isAuthorized') ??
        false;
  }
}
