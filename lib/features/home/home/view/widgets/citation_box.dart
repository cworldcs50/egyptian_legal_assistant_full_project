import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/adaptive_layout.dart';
import '../../../chatbot/models/citation_model.dart';

class CitationBox extends StatelessWidget {
  const CitationBox({super.key, required this.citation});

  final Citation citation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16.0),
      ),
      decoration: BoxDecoration(
        color: AppColors.muted(context),
        border: Border.all(
          color: AppColors.ring(context).withValues(alpha: 0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.circle,
                color: AppColors.primary(context),
                size: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 8,
                ),
              ),
              SizedBox(
                width: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 8,
                ),
              ),
              Text(
                citation.lawName,
                style: TextStyle(
                  color: AppColors.primary(context),
                  fontWeight: FontWeight.bold,
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
          ),
          Text(
            citation.articleNumber,
            style: TextStyle(
              color: AppColors.ring(context),
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 13,
              ),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
          Text(
            citation.text,
            style: TextStyle(
              color: AppColors.mutedForeground(context),
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 14,
              ),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
