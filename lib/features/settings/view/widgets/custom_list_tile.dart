import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const CustomListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      leading: Icon(
        icon,
        color: AppColors.primary(context),
        size: 24,
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
      onTap: onTap,
    );
  }
}