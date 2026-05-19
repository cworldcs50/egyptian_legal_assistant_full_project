import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

class OnboardingInProgress extends OnboardingState {
  const OnboardingInProgress({required this.currentPage});

  final int currentPage;

  @override
  List<Object> get props => [currentPage];
}

class OnboardingCompleted extends OnboardingState {}
