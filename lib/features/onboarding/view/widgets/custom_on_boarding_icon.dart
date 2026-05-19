import 'package:flutter/material.dart';
import '../../../../core/widgets/adaptive_layout.dart';
import '../../../../core/theme/app_colors.dart';

class CustomOnBoardingIcon extends StatelessWidget {
  const CustomOnBoardingIcon({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      // shadowColor:
      //     Theme.of(context).brightness == Brightness.dark
      //         ? Colors.white
      //         : Colors.black,
      shape: const CircleBorder(),
      child: Container(
        width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 200),
        height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 200),
        decoration: BoxDecoration(
          color: AppColors.card(context),
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withValues(alpha: 0.5)
                      : Colors.black.withValues(alpha: 0.1),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 120),
          color: AppColors.primary(context),
        ),
      ),
    );
  }
}
