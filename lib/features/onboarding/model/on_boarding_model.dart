import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class OnBoardingModel extends Equatable {
  final IconData icon;
  final String title, description;

  const OnBoardingModel({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description, icon];
}
