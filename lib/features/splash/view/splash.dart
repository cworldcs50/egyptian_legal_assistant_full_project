import 'package:flutter/material.dart';
import '../model/splash_data.dart';
import 'widgets/custom_egyptian_flag.dart';
import '../../../core/widgets/adaptive_layout.dart';
import '../../../core/theme/app_colors.dart';
import '../../onboarding/view/onboarding_view.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _glowController;

  late Animation<double> _glowOpacity;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  late Animation<double> flagFade;
  late Animation<double> _textFade;
  late Animation<Offset> flagSlide;
  late Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = Tween<double>(
      end: 1,
      begin: 0.8,
    ).animate(CurvedAnimation(parent: _mainController, curve: Curves.easeOut));

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 1, curve: Curves.easeOut),
      ),
    );

    _textFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 1, curve: Curves.easeOut),
      ),
    );

    flagSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.8, 1, curve: Curves.easeOut),
      ),
    );

    flagFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.8, 1, curve: Curves.easeOut),
      ),
    );

    _fadeAnimation = Tween<double>(
      end: 1,
      begin: 0,
    ).animate(CurvedAnimation(parent: _mainController, curve: Curves.easeOut));

    _glowOpacity = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _mainController.forward();
    _glowController.repeat(reverse: true);

    _mainController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(
          const Duration(seconds: 5),
          () async => await Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const OnboardingView()),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _glowOpacity,
                      builder: (context, child) {
                        return Container(
                          width: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 100,
                          ),
                          height: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 100,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.splashShadowColor(
                                  context,
                                ).withValues(alpha: _glowOpacity.value),
                                blurRadius:
                                    AdaptiveLayout.getResponsiveFontSize(
                                      context,
                                      fontSize: 20,
                                    ),
                                spreadRadius:
                                    AdaptiveLayout.getResponsiveFontSize(
                                      context,
                                      fontSize: 5,
                                    ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Icon(
                      SplashViewData.kSplashBalance,
                      size: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 100,
                      ),
                      color: AppColors.splashLogoColor(context),
                    ),
                  ],
                ),
                FadeTransition(
                  opacity: _textFade,
                  child: SlideTransition(
                    position: _textSlide,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          SplashViewData.kSplashTitle,
                          style: TextStyle(
                            fontSize: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 20,
                            ),
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary(context),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 8,
                          ),
                        ),
                        Text(
                          SplashViewData.kSplashSubTitle,
                          style: TextStyle(
                            fontSize: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 14,
                            ),
                            fontWeight: FontWeight.w600,
                            color: AppColors.foreground(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 3),
                FadeTransition(
                  opacity: _textFade,
                  child: SizedBox(
                    width: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 200,
                    ),
                    child: const CustomEgyptianFlag(),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
