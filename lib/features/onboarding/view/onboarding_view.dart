import 'package:flutter/material.dart';
import '../../../core/functions/listen_to_notification.dart';
import '../../../core/services/notification_service.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../model/on_boarding_data.dart';
import 'widgets/custom_elevated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/page_indicator.dart';
import '../../../core/widgets/adaptive_layout.dart';
import '../../../core/theme/app_colors.dart';
import 'widgets/custom_page_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  void initState() {
    NotificationService.instance.getNotificationPermission();
    listenToNotification(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(),
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                left: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 10.0,
                ),
                right: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 10.0,
                ),
                bottom: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 30.0,
                ),
              ),
              child:
                  !context.read<OnboardingBloc>().isLastPage
                      ? Row(
                        spacing: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 15.0,
                        ),
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.card(context),
                                foregroundColor: AppColors.primary(context),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AdaptiveLayout.getResponsiveFontSize(
                                      context,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                  side: BorderSide(
                                    color: AppColors.primary(context),
                                  ),
                                ),
                              ),
                              onPressed:
                                  () => context.read<OnboardingBloc>().add(
                                    OnboardingNextPage(
                                      currentPage:
                                          context
                                              .read<OnboardingBloc>()
                                              .currentPage +
                                          1,
                                    ),
                                  ),
                              child: Icon(
                                OnBoardingData.nextIcon,
                                weight: 600,
                                size: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary(context),
                                foregroundColor: AppColors.primaryForeground(
                                  context,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AdaptiveLayout.getResponsiveFontSize(
                                      context,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed:
                                  () => context.read<OnboardingBloc>().add(
                                    OnboardingPreviousPage(
                                      currentPage:
                                          context
                                              .read<OnboardingBloc>()
                                              .currentPage -
                                          1,
                                    ),
                                  ),
                              child: Icon(
                                OnBoardingData.previousIcon,
                                weight: 600,
                                size: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      : CustomElevatedButton(
                        title: OnBoardingData.kStartNow,
                        onPressed:
                            () => context.read<OnboardingBloc>().add(
                              OnboardingComplete(context: context),
                            ),
                      ),
            ),
            body: Column(
              children: [
                const Spacer(flex: 2),
                Expanded(
                  flex: 14,
                  child: CustomPageView(
                    controller: context.read<OnboardingBloc>().pageController,
                    onPageChanged:
                        (index) => context.read<OnboardingBloc>().add(
                          OnboardingNextPage(currentPage: index),
                        ),
                  ),
                ),
                Expanded(
                  child: PageIndicator(
                    activeColor: AppColors.pageIndicatorActiveColor(context),
                    inactiveColor: AppColors.pageIndicatorInActiveColor(
                      context,
                    ),
                    pageCount: OnBoardingData.onboardingPages.length,
                    currentPage: context.read<OnboardingBloc>().currentPage,
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          );
        },
      ),
    );
  }
}
