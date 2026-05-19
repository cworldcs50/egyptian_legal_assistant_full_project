import 'package:fpdart/fpdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/error/failure.dart';
import '../models/user_model.dart';
import 'i_auth_repository.dart';
import 'remote/i_auth_remote_data_source.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async =>await  remoteDataSource.signInWithEmailAndPassword(
    email: email,
    password: password,
    displayName: displayName
  );

  @override
  Future<Either<Failure, UserCredential>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) => remoteDataSource.signUpWithEmailAndPassword(
    email: email,
    password: password,
    displayName: displayName
  );

  @override
  Future<Either<Failure, UserCredential>> signInWithGoogle() async =>
      await remoteDataSource.signInWithGoogle();

  @override
  Future<Either<Failure, UserCredential>> signInWithFacebook() async =>
      await remoteDataSource.signInWithFacebook();

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async =>
      await remoteDataSource.resetPassword(email: email);

  @override
  Future<Either<Failure, void>> logout() async =>
      await remoteDataSource.logout();

  @override
  Future<void> saveUserData({required UserModel userModel}) async =>
      await remoteDataSource.saveUserData(userModel: userModel);

  @override
  Future<void> setIsAuthorized(bool isAuthorized) async =>
      await remoteDataSource.setIsAuthorized(isAuthorized);

  @override
  bool getIsAuthorized() => remoteDataSource.getIsAuthorized();
}
