import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/adaptive_layout.dart';

class CustomSubTitle extends StatelessWidget {
  const CustomSubTitle({super.key, required this.subTitle});

  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      style: TextStyle(
        fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
        color: AppColors.subTitleColor(context),
      ),
      textAlign: TextAlign.center,
    );
  }
}
