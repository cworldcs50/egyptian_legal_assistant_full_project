import 'package:flutter/material.dart';

import '../../model/on_boarding_data.dart';
import 'custom_on_boarding_page.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({
    super.key,
    required this.onPageChanged,
    required this.controller,
  });

  final PageController controller;
  final void Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: onPageChanged,
      children: List.generate(
        OnBoardingData.onboardingPages.length,
        (index) => CustomOnBoardingPage(
          onBoardingModel: OnBoardingData.onboardingPages[index],
        ),
      ),
    );
  }
}
