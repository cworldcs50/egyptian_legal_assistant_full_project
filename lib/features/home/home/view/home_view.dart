import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/service_locator.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_events.dart';
import 'responsive_layouts/mobile_layout.dart';
import 'responsive_layouts/tablet_layout.dart';
import 'responsive_layouts/desktop_layout.dart';
import '../../../../core/widgets/adaptive_layout.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Use BlocProvider.value so the singleton is not closed when HomeView pops
    final homeBloc = sl<HomeBloc>();
    homeBloc.add(SendWelcomeMessageEvent());
    return BlocProvider.value(
      value: homeBloc,
      child: AdaptiveLayout(
        mobileLayout: (context) => const MobileLayout(),
        tabletLayout: (context) => const TabletLayout(),
        desktopLayout: (context) => const DesktopLayout(),
      ),
    );
  }
}
