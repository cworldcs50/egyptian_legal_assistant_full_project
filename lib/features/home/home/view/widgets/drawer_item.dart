import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/adaptive_layout.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary(context),
        size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : const Color(0XFF222222),
          fontWeight: FontWeight.w600,
          fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 15),
        ),
      ),
      onTap: onTap,
    );
  }
}
