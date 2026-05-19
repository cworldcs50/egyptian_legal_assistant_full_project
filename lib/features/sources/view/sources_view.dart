import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/adaptive_layout.dart';
import '../../../core/widgets/app_state_widget.dart';
import '../repository/datasource/local/source_view_local_data.dart';
import '../bloc/sources_bloc.dart';
import '../bloc/sources_states.dart';
import '../bloc/sources_events.dart';
import '../../../core/services/service_locator.dart';
import 'widgets/custom_source_container.dart';

class SourcesView extends StatelessWidget {
  const SourcesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SourcesBloc>()..add(GetSourcesEvent()),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.background(context),
          appBar: AppBar(
            backgroundColor: AppColors.background(context),
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                SourceViewData.arrowRight,
                color: AppColors.primary(context),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text(
              SourceViewData.kUsedLaws,
              style: TextStyle(
                color: AppColors.primary(context),
                fontWeight: FontWeight.bold,
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 18,
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(color: AppColors.ring(context), height: 1.0),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: BlocBuilder<SourcesBloc, BaseSourcesState>(
                  builder: (context, state) {
                    if (state is LoadingSourcesState) {
                      return const AppStateWidget.loading();
                    } else if (state is FailureSourcesState) {
                      return AppStateWidget.serverFailure(
                        message: state.failure.message,
                        onRetry: () =>
                            context.read<SourcesBloc>().add(GetSourcesEvent()),
                      );
                    } else if (state is SuccessSourcesState) {
                      return LiquidPullToRefresh(
                        onRefresh: () async {
                          context.read<SourcesBloc>().add(GetSourcesEvent());
                        },
                        color: AppColors.primary(context),
                        backgroundColor: AppColors.card(context),
                        showChildOpacityTransition: false,
                        child: ListView(
                          padding: EdgeInsets.all(
                            AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 16.0,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 24.0,
                                ),
                                top: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 4.0,
                                ),
                              ),
                              child: Text(
                                SourceViewData
                                    .kEgyptianLegalAssistantSourcesDescription,
                                style: TextStyle(
                                  color: AppColors.foreground(context),
                                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                                    context,
                                    fontSize: 14,
                                  ),
                                  height: 1.5,
                                ),
                              ),
                            ),
                            ...state.legalSources.map(
                              (source) =>
                                  CustomSourceContainer(legalSource: source),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
              // Footer Disclaimer
              Container(
                padding: EdgeInsets.all(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16.0),
                ),
                color: AppColors.background(context),
                child: SafeArea(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        height: 1.5,
                        fontSize: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 12,
                        ),
                        fontFamily: 'Cairo',
                        color: AppColors.mutedForeground(context),
                      ),
                      children: [
                        TextSpan(
                          text: SourceViewData.kWarning,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary(context),
                          ),
                        ),
                        const TextSpan(
                          text: SourceViewData.kWarningDescription,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
