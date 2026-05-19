import 'custom_sub_title.dart';
import 'custom_on_boarding_icon.dart';
import 'package:flutter/material.dart';
import 'custom_on_boarding_title.dart';
import '../../model/on_boarding_model.dart';

class CustomOnBoardingPage extends StatelessWidget {
  const CustomOnBoardingPage({super.key, required this.onBoardingModel});

  final OnBoardingModel onBoardingModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomOnBoardingIcon(icon: onBoardingModel.icon),
        const Spacer(),
        CustomOnBoardingTitle(title: onBoardingModel.title),
        CustomSubTitle(subTitle: onBoardingModel.description),
        const Spacer(),
      ],
    );
  }
}
