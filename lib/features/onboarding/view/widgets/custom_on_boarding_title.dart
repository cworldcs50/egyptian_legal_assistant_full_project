import 'package:flutter/material.dart';
import '../../../../core/widgets/adaptive_layout.dart';
import '../../../../core/theme/app_colors.dart';

class CustomOnBoardingTitle extends StatelessWidget {
  const CustomOnBoardingTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 30),
        fontWeight: FontWeight.bold,
        color: AppColors.primary(context),
      ),
      textAlign: TextAlign.center,
    );
  }
}

