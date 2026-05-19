import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CustomSectionTitle extends StatelessWidget {
  final String title;

  const CustomSectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.primary(context),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}