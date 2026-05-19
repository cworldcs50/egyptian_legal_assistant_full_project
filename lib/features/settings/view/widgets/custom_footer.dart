import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/adaptive_layout.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(
        horizontal: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 12,
            ),
            height: 1.6,
            fontFamily: 'Cairo', // ensure custom font applies
            color: AppColors.mutedForeground(context),
          ),
          children: [
            TextSpan(
              text: 'ملاحظة: ',
              style: TextStyle(
                color: AppColors.primary(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(
              text:
                  'هذا التطبيق يقدم معلومات قانونية عامة ولا يشكل استشارة قانونية رسمية. للحصول على استشارة قانونية معتمدة يُرجى استشارة محامٍ مرخص.',
            ),
          ],
        ),
      ),
    );
  }
}
