import 'on_boarding_model.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OnBoardingData {
  static const String kStartNow = "ابدأ الآن";
  static const List<OnBoardingModel> onboardingPages = [
    OnBoardingModel(
      icon: LucideIcons.brain,
      title: "المساعد القانوني المصري",
      description: "Egyptian Legal Assistant",
    ),
    OnBoardingModel(
      icon: LucideIcons.fileText,
      title: "إجابات موثقة بالمصادر",
      description:
          "كل إجابة تعتمد على مواد من الدستور والقانون المدني وقانون الإجراءات الجنائية.",
    ),
    OnBoardingModel(
      icon: Icons.balance,
      title: "اسأل عن القانون المصري بسهولة",
      description: "احصل على إجابات دقيقة مبنية على القوانين المصرية الرسمية.",
    ),
  ];
  static const IconData nextIcon = Icons.arrow_back_ios_outlined;
  static const IconData previousIcon = Icons.arrow_forward_ios_outlined;
}
