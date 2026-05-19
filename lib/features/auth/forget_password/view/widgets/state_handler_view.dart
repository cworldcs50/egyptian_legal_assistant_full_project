import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/enums/request_statuts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/adaptive_layout.dart';
import '../../../../../core/constants/app_assets_constants.dart';

class StateHandlerView extends StatelessWidget {
  const StateHandlerView({
    super.key,
    required this.requestStatus,
    required this.child,
  });

  final Widget child;
  final RequestStatuts? requestStatus;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          switch (requestStatus) {
            RequestStatuts.loading => Lottie.asset(
              AppAssetsConstants.loadingLottie,
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 150,
              ),
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 150,
              ),
            ),
            RequestStatuts.failure => Lottie.asset(
              AppAssetsConstants.failureLottie,
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 150,
              ),
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 150,
              ),
            ),
            RequestStatuts.success => child,
            null => child,
            RequestStatuts.offline => Lottie.asset(
              AppAssetsConstants.offlineLottie,
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 150,
              ),
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 150,
              ),
            ),

            RequestStatuts.serverFailure => Lottie.asset(
              AppAssetsConstants.serverFailureLottie,
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 150,
              ),
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 150,
              ),
            ),
          },
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary(context),
            ),
            child: Text(
              "حاول مرة اخري",
              style: TextStyle(
                color: AppColors.foreground(context),
                fontWeight: FontWeight.bold,
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
