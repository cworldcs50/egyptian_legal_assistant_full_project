import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class OnboardingNextPage extends OnboardingEvent {
  const OnboardingNextPage({required this.currentPage});

  final int currentPage;

  @override
  List<Object> get props => [currentPage];
}

class OnboardingPreviousPage extends OnboardingEvent {
  const OnboardingPreviousPage({required this.currentPage});

  final int currentPage;

  @override
  List<Object> get props => [currentPage];
}

class OnboardingComplete extends OnboardingEvent {
  const OnboardingComplete({required this.context});

  final BuildContext context;

  @override
  List<Object> get props => [context];
}
