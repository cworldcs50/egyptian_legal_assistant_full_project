import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/adaptive_layout.dart';

class CustomSwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitchTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        secondary: Icon(
          icon,
          color: AppColors.primary(context),
          size: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.foreground(context),
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            subtitle,
            style: TextStyle(
              color: AppColors.mutedForeground(context),
              fontSize: 13,
            ),
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeThumbColor: Colors.white,
        activeTrackColor: AppColors.primary(context),
        inactiveThumbColor: Colors.white,
        inactiveTrackColor:
            AppColors.border(context).withValues(alpha: 0.5),
      ),
    );
  }
}