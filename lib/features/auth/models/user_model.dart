import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.userName,
    required this.email,
    required this.userId,
  });

  final String userName, email, userId;

  factory UserModel.fromFirebaseUser(User user) {
    user.reload();
    return UserModel(
      userName: user.displayName ?? '',
      email: user.email ?? '',
      userId: user.uid,
    );
  }

  @override
  List<Object?> get props => [userName, email, userId];
}
