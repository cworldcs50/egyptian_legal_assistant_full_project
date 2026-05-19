import '../../../../core/theme/app_colors.dart';
import '../bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'responsive_layouts/mobile_layout.dart';
import 'responsive_layouts/tablet_layout.dart';
import 'responsive_layouts/desktop_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/adaptive_layout.dart';

import '../../../../core/services/service_locator.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignInBloc>(),
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
              mobileLayout: (context) => const SignInMobileLayout(),
              tabletLayout: (context) => const SignInTabletLayout(),
              desktopLayout: (context) => const SignInDesktopLayout(),
            ),
          ),
        ),
      ),
    );
  }
}
