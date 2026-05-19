import 'package:flutter/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../models/feature_item_model.dart';

class AboutViewLocalData {
  static const String kAboutApp = 'عن التطبيق';
  static const String kEgyptianLegalAssistantArabic = 'المساعد القانوني المصري';
  static const String kEgyptianLegalAssistantEnglish = 'Egyptian Legal Assistant';
  static const IconData arrowRight = LucideIcons.arrowRight;
  static const IconData scale = LucideIcons.scale;
 static final  List<FeatureItem> features = const [
    FeatureItem(
      title: 'ذكاء اصطناعي متقدم',
      description:
          'نستخدم تقنيات الذكاء الاصطناعي الحديثة لفهم أسئلتك وتقديم إجابات دقيقة',
      icon:
          LucideIcons
              .brain, 
    ),
    FeatureItem(
      title: 'مبني على القانون المصري',
      description:
          'جميع الإجابات مستمدة من القوانين والتشريعات المصرية الرسمية',
      icon: LucideIcons.scale,
    ),
    FeatureItem(
      title: 'موثوق وآمن',
      description: 'نحافظ على خصوصية بياناتك ولا نشارك محادثاتك مع أي جهة',
      icon: LucideIcons.shield,
    ),
    FeatureItem(
      title: 'إجابات واضحة',
      description: 'نقدم شرحاً مبسطاً للمواد القانونية بلغة عربية واضحة',
      icon: LucideIcons.target,
    ),
  ];


}