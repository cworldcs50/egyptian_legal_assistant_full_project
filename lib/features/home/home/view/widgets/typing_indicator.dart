import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/adaptive_layout.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        margin: EdgeInsets.only(
          bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24.0),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 16.0,
          ),
          vertical: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 10.0,
          ),
        ),
        decoration: BoxDecoration(
          color: AppColors.card(context),
          border: Border.all(
            color: AppColors.ring(context).withValues(alpha: 0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'المساعد يكتب',
              style: TextStyle(
                color: AppColors.ring(context),
                fontWeight: FontWeight.w600,
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final delay = index * 0.2;
                    double value = (_controller.value - delay) * 2;
                    if (value < 0) value += 2;
                    if (value > 1) value = 2 - value;

                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 2.0,
                        ),
                      ),
                      width: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 6,
                      ),
                      height: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.ring(context).withValues(
                          alpha: 0.3 + (value * 0.7).clamp(0.0, 0.7),
                        ),
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
