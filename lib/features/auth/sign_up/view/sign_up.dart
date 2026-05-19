import '../bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'responsive_layouts/mobile_layout.dart';
import 'responsive_layouts/tablet_layout.dart';
import 'responsive_layouts/desktop_layout.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/adaptive_layout.dart';
import '../../../../core/services/service_locator.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignUpBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.background(context),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 24,
              ),
            ),
            child: AdaptiveLayout(
              mobileLayout: (context) => const SignUpMobileLayout(),
              tabletLayout: (context) => const SignUpTabletLayout(),
              desktopLayout: (context) => const SignUpDesktopLayout(),
            ),
          ),
        ),
      ),
    );
  }
}
