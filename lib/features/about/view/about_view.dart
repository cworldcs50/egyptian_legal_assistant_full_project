import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/adaptive_layout.dart';
import '../repository/datasource/about_view_local_data.dart';




class AboutView extends StatelessWidget {
  const AboutView({super.key});

    @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background(context),
        appBar: AppBar(
          backgroundColor: AppColors.background(context),
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              AboutViewLocalData.arrowRight,
              color: AppColors.primary(context),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(
            AboutViewLocalData.kAboutApp,
            style: TextStyle(
              color: AppColors.primary(context),
              fontWeight: FontWeight.bold,
              fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
            ),
          ),
          bottom: PreferredSize(
            preferredSize:  Size.fromHeight(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 1)),
            child: Container(color: AppColors.ring(context), height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 1)),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24.0)),
          children: [
            // Header Section
            Column(
              children: [
                Icon(
                  AboutViewLocalData.scale,
                  size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 64),
                  color: AppColors.primary(context),
                ),
                SizedBox(height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16)),
                Text(
                  AboutViewLocalData.kEgyptianLegalAssistantArabic,
                  style: TextStyle(
                    color: AppColors.primary(context),
                    fontWeight: FontWeight.bold,
                    fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
                  ),
                ),
                SizedBox(height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4)),
                Text(
                  AboutViewLocalData.kEgyptianLegalAssistantEnglish,
                  style: TextStyle(
                    color: AppColors.primaryReverse(context),
                    fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 32)),

            // Description Box
            Container(
              padding: EdgeInsets.all(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20.0)),
              decoration: BoxDecoration(
                color: AppColors.card(context),
                borderRadius: BorderRadius.circular(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12)),
                border: Border.all(
                  color: AppColors.ring(context).withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              child: Text(
                'المساعد القانوني المصري هو تطبيق ذكاء اصطناعي متخصص في القانون المصري. يساعدك على فهم حقوقك وواجباتك القانونية من خلال تقديم إجابات دقيقة مبنية على القوانين المصرية الرسمية.',
                style: TextStyle(
                  color: AppColors.foreground(context),
                  fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
                  height: 1.6,
                ),
              ),
            ),
            SizedBox(height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 32)),

            // Features Section
            Text(
              'مميزات التطبيق',
              style: TextStyle(
                color: AppColors.primary(context),
                fontWeight: FontWeight.bold,
                fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
              ),
            ),
            SizedBox(height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16)),
            ...AboutViewLocalData.features.map((feature) {
              return Container(
                margin:  EdgeInsets.only(bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12.0)),
                padding: EdgeInsets.all(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16.0)),
                decoration: BoxDecoration(
                  color: AppColors.card(context),
                  borderRadius: BorderRadius.circular(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12)),
                  border: Border.all(
                    color: AppColors.ring(context).withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12)),
                      decoration: BoxDecoration(
                        color: AppColors.primary(
                          context,
                        ).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12)),
                      ),
                      child: Icon(
                        feature.icon,
                        color: AppColors.primary(context),
                        size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
                      ),
                    ),
                    SizedBox(width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            feature.title,
                            style: TextStyle(
                              color: AppColors.primary(context),
                              fontWeight: FontWeight.bold,
                              fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
                            ),
                          ),
                          SizedBox(height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4)),
                          Text(
                            feature.description,
                            style: TextStyle(
                              color: AppColors.mutedForeground(context),
                              fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 13),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

            SizedBox(height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 32)),

            // Footer
            Column(
              children: [
                Text(
                  'الإصدار 1.0.0',
                  style: TextStyle(
                    color: AppColors.mutedForeground(context),
                    fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
                  ),
                ),
                SizedBox(height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4)),
                Text(
                  '© 2026 المساعد القانوني المصري. جميع الحقوق محفوظة.',
                  style: TextStyle(
                    color: AppColors.mutedForeground(context),
                    fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
