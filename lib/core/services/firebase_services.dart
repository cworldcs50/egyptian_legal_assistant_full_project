import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import '../classes/error_model.dart';
import '../functions/is_online.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FirebaseService {
  const FirebaseService._();
  factory FirebaseService() => _instance;

  static const _instance = FirebaseService._();

  FirebaseAuth get instance => FirebaseAuth.instance;

  Future<Either<ErrorModel, UserCredential>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      if (await isOnline()) {
        final result = await instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await result.user!.updateDisplayName(displayName);
        await result.user?.reload();
        return Right(result);
      } else {
        return const Left(
          ErrorModel(title: 'Error!', message: "No Internet Connection!"),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Left(
          ErrorModel(
            title: 'weak-password',
            message: 'The password provided is too weak.',
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        return const Left(
          ErrorModel(
            title: 'email-already-in-use',
            message: 'The account already exists for that email.',
          ),
        );
      } else {
        return const Left(
          ErrorModel(title: 'Error!', message: "Error In Email or Password!"),
        );
      }
    } catch (_) {
      return const Left(
        ErrorModel(title: 'Error!', message: "Error In Email or Password!"),
      );
    }
  }

  Future<Either<ErrorModel, UserCredential>> signInWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      if (await isOnline()) {
        final credential = await instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        await credential.user?.updateDisplayName(displayName);
        await instance.currentUser?.reload();
        return Right(credential);
      } else {
        return const Left(
          ErrorModel(title: 'Error!', message: "No Internet Connection!"),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left(
          ErrorModel(
            title: 'user-not-found',
            message: 'No user found for that email.',
          ),
        );
      } else if (e.code == 'wrong-password') {
        return const Left(
          ErrorModel(
            title: 'wrong-password',
            message: 'Wrong password provided for that user.',
          ),
        );
      } else {
        return const Left(
          ErrorModel(title: 'Error!', message: "Error In Email or Password!"),
        );
      }
    } catch (_) {
      return const Left(
        ErrorModel(title: 'Error!', message: "Error In Email or Password!"),
      );
    }
  }

  Future<Either<ErrorModel, void>> logout() async {
    try {
      if (await isOnline()) {
        return Right(await instance.signOut());
      } else {
        return const Left(
          ErrorModel(title: 'Error!', message: "No Internet Connection!"),
        );
      }
    } on FirebaseAuthException catch (e) {
      return Left(ErrorModel(title: e.code, message: e.message ?? ""));
    } catch (e) {
      return const Left(
        ErrorModel(title: 'Error!', message: "Error in logout!"),
      );
    }
  }

  Future<Either<ErrorModel, void>> resetPassword(String email) async {
    try {
      if (await isOnline()) {
        await instance.sendPasswordResetEmail(email: email);
        return const Right(null);
      } else {
        return const Left(
          ErrorModel(title: 'Error!', message: "No Internet Connection!"),
        );
      }
    } on FirebaseAuthException catch (e) {
      return Left(ErrorModel(title: e.code, message: e.message ?? ""));
    } catch (e) {
      return const Left(
        ErrorModel(title: 'Error!', message: "Error in password reset!"),
      );
    }
  }

  Future<Either<ErrorModel, UserCredential>> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      if (await isOnline()) {
        await googleSignIn.initialize(
          serverClientId:
              "713206219196-1d8n36qrgjukjur821si4dtctmd80s6e.apps.googleusercontent.com",
        );
      } else {
        return const Left(
          ErrorModel(title: 'Error!', message: "No Internet Connection!"),
        );
      }

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.idToken,
      );

      final userCredential = await instance.signInWithCredential(credential);
      await userCredential.user?.updateDisplayName(googleUser.displayName);
      await userCredential.user?.reload();
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(ErrorModel(title: e.code, message: e.message ?? ""));
    } catch (e) {
      log("Google Sign-In Error: $e");
      return Left(ErrorModel(title: 'Error!', message: e.toString()));
    }
  }

  Future<Either<ErrorModel, UserCredential>> signInWithFacebook() async {
    try {
      final facebookAuth = FacebookAuth.instance;
      if (await isOnline()) {
        await facebookAuth.webAndDesktopInitialize(
          appId: "1642861950476727",
          cookie: true,
          xfbml: true,
          version: "v19.0",
        );
      } else {
        return const Left(
          ErrorModel(title: 'Error!', message: "No Internet Connection!"),
        );
      }
      final LoginResult loginResult = await facebookAuth.login();

      if (loginResult.status != LoginStatus.success) {
        return const Left(
          ErrorModel(title: 'Error!', message: "Facebook login failed!"),
        );
      }

      final OAuthCredential credential = FacebookAuthProvider.credential(
        loginResult.accessToken!.tokenString,
      );

      final userCredential = await instance.signInWithCredential(credential);
      await userCredential.user?.updateDisplayName(
        userCredential.user?.displayName,
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(ErrorModel(title: e.code, message: e.message ?? ""));
    } catch (e) {
      log(e.toString());
      return Left(ErrorModel(title: 'Error!', message: e.toString()));
    }
  }
}
