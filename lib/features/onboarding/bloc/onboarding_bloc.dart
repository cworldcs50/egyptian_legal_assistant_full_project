import 'onboarding_event.dart';
import 'onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/shared_preference/shared_preference.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  int currentPage = 0;
  bool isLastPage = false;
  static const int totalPages = 3;
  final PageController pageController = PageController();

  OnboardingBloc() : super(const OnboardingInitial()) {
    on<OnboardingNextPage>(_onNextPage);
    on<OnboardingPreviousPage>(_onPreviousPage);
    on<OnboardingComplete>(
      (event, emit) => _onComplete(event, emit, event.context),
    );
  }

  void _onNextPage(
    OnboardingNextPage event,
    Emitter<OnboardingState> emit,
  ) async {
    currentPage = event.currentPage;
    isLastPage = (event.currentPage == totalPages - 1);

    if (currentPage < 0) {
      currentPage = 0;
    }

    emit(OnboardingInProgress(currentPage: currentPage));

    await pageController.animateToPage(
      currentPage,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 1200),
    );
  }

  void _onPreviousPage(
    OnboardingPreviousPage event,
    Emitter<OnboardingState> emit,
  ) async {
    isLastPage = (event.currentPage == totalPages - 1);
    currentPage = event.currentPage;

    if (currentPage < 0) {
      currentPage = 0;
    }

    emit(OnboardingInProgress(currentPage: currentPage));

    await pageController.animateToPage(
      currentPage,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 1200),
    );
  }

  void _onComplete(
    OnboardingComplete event,
    Emitter<OnboardingState> emit,
    BuildContext context,
  ) async {
    emit(OnboardingCompleted());
    await SharedPreference.sharedPreferencesInstance.setBool(
      'isFirstTime',
      false,
    );
    // ignore: use_build_context_synchronously
    await Navigator.of(context).pushReplacementNamed(AppConstants.signInRoute);
  }
}
