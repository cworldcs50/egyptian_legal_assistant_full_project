import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/adaptive_layout.dart';

/// A themed social login button (e.g. Google, Facebook).
class CustomSocialButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;

  const CustomSocialButton({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.card(context),
        foregroundColor: AppColors.foreground(context),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: AppColors.border(context)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 12),
          Text(
            text,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w600,
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 14,
              ),
              color: AppColors.foreground(context),
            ),
          ),
        ],
      ),
    );
  }
}
