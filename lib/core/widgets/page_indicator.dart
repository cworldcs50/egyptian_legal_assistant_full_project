import 'package:flutter/material.dart';

import 'adaptive_layout.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;
  final Color activeColor;
  final Color inactiveColor;

  const PageIndicator({
    super.key,
    required this.pageCount,
    required this.activeColor,
    required this.currentPage,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(pageCount, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          margin: EdgeInsets.symmetric(
            horizontal: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 5,
            ),
          ),
          width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentPage ? activeColor : inactiveColor,
          ),
        );
      }),
    );
  }
}
