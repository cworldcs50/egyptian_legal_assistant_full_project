import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable {
  final String title;
  final String message;

  const ErrorModel({required this.title, required this.message});

  @override
  List<Object?> get props => [title, message];
}