import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// A reusable widget that renders a Lottie animation
/// with a color filter applied for dark mode visibility.
class AppLottieWidget extends StatelessWidget {
  final String lottiePath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool repeat;

  const AppLottieWidget({
    super.key,
    required this.lottiePath,
    this.width,
    this.height,
    this.fit,
    this.repeat = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ColorFiltered(
      // In dark mode, invert the lottie brightness slightly
      colorFilter:
          isDark
              ? const ColorFilter.matrix(<double>[
                0.8,
                0,
                0,
                0,
                30,
                0,
                0.8,
                0,
                0,
                30,
                0,
                0,
                0.8,
                0,
                30,
                0,
                0,
                0,
                1,
                0,
              ])
              : const ColorFilter.matrix(<double>[
                1,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
              ]),
      child: Lottie.asset(
        lottiePath,
        width: width,
        height: height,
        fit: fit,
        repeat: repeat,
      ),
    );
  }
}
