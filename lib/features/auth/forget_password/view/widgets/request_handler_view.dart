import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/adaptive_layout.dart';

class RequestHandlerView extends StatelessWidget {
  const RequestHandlerView({super.key, required this.imgPath});

  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 150),
        height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 150),
        imgPath,
      ),
    );
  }
}