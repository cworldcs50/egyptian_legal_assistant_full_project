import 'custom_history_body.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_events.dart';
import '../bloc/history_states.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/adaptive_layout.dart';
import '../../../core/services/service_locator.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyBloc = sl<HistoryBloc>();
    
    return BlocProvider.value(
      value: historyBloc..add(const FetchSessionsEvent()),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.background(context),
          appBar: AppBar(
            backgroundColor: AppColors.background(context),
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                LucideIcons.arrowRight,
                color: AppColors.primary(context),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text(
              'المحادثات السابقة',
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
              preferredSize: Size.fromHeight(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 1.0),
              ),
              child: Container(
                color: AppColors.ring(context),
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 1.0,
                ),
              ),
            ),
          ),
          body: BlocBuilder<HistoryBloc, HistoryStates>(
            builder: (context, state) {
              return LiquidPullToRefresh(
                onRefresh: () async {
                  context.read<HistoryBloc>().add(const FetchSessionsEvent());
                },
                color: AppColors.primary(context),
                backgroundColor: AppColors.card(context),
                showChildOpacityTransition: false,
                child: CustomHistoryBody(state: state),
              );
            },
          ),
        ),
      ),
    );
  }

  // Widget _buildBody(BuildContext context, HistoryStates state) {
  //   if (state is HistoryLoading) {
  //     return const AppStateWidget.loading();
  //   }

  //   if (state is HistoryError) {
  //     return AppStateWidget.databaseError(
  //       message: state.errorModel.message,
  //       onRetry:
  //           () => context.read<HistoryBloc>().add(const FetchSessionsEvent()),
  //     );
  //   }

  //   if (state is HistorySuccess) {
  //     final sessions = state.sessions;

  //     if (sessions.isEmpty) {
  //       return AppStateWidget.empty(
  //         message: 'لا توجد محادثات سابقة',
  //         onRetry:
  //             () => context.read<HistoryBloc>().add(const FetchSessionsEvent()),
  //       );
  //     }

  //     return ListView.builder(
  //       padding: EdgeInsets.all(
  //         AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16.0),
  //       ),
  //       itemCount: sessions.length,
  //       itemBuilder: (context, index) {
  //         final session = sessions[index];
  //         final String title = session['title'] ?? 'محادثة جديدة';
  //         final String description = session['last_message'] ?? '';
  //         final DateTime date = DateTime.parse(session['updated_at']);
  //         final String formattedDate = intl.DateFormat(
  //           'd MMMM yyyy',
  //           'ar',
  //         ).format(date);

  //         return GestureDetector(
  //           onTap: () {
  //             context.read<HomeBloc>().add(LoadSessionEvent(session['id']));
  //             Navigator.pop(context);
  //           },
  //           child: Container(
  //             margin: EdgeInsets.only(
  //               bottom: AdaptiveLayout.getResponsiveFontSize(
  //                 context,
  //                 fontSize: 16.0,
  //               ),
  //             ),
  //             decoration: BoxDecoration(
  //               color: AppColors.card(context),
  //               borderRadius: BorderRadius.circular(
  //                 AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
  //               ),
  //               border: Border.all(
  //                 color: AppColors.ring(context).withValues(alpha: 0.5),
  //                 width: 1,
  //               ),
  //             ),
  //             child: Padding(
  //               padding: EdgeInsets.all(
  //                 AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16.0),
  //               ),
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           title,
  //                           maxLines: 1,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: TextStyle(
  //                             color: AppColors.primary(context),
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: AdaptiveLayout.getResponsiveFontSize(
  //                               context,
  //                               fontSize: 16,
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: AdaptiveLayout.getResponsiveFontSize(
  //                             context,
  //                             fontSize: 4,
  //                           ),
  //                         ),
  //                         Text(
  //                           description,
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: TextStyle(
  //                             color: AppColors.mutedForeground(context),
  //                             fontSize: AdaptiveLayout.getResponsiveFontSize(
  //                               context,
  //                               fontSize: 14,
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: AdaptiveLayout.getResponsiveFontSize(
  //                             context,
  //                             fontSize: 8,
  //                           ),
  //                         ),
  //                         Row(
  //                           children: [
  //                             Icon(
  //                               LucideIcons.calendar,
  //                               color: AppColors.ring(context),
  //                               size: AdaptiveLayout.getResponsiveFontSize(
  //                                 context,
  //                                 fontSize: 14,
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               width: AdaptiveLayout.getResponsiveFontSize(
  //                                 context,
  //                                 fontSize: 4,
  //                               ),
  //                             ),
  //                             Text(
  //                               formattedDate,
  //                               style: TextStyle(
  //                                 color: AppColors.ring(context),
  //                                 fontSize:
  //                                     AdaptiveLayout.getResponsiveFontSize(
  //                                       context,
  //                                       fontSize: 12,
  //                                     ),
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: AdaptiveLayout.getResponsiveFontSize(
  //                       context,
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                   Container(
  //                     padding: EdgeInsets.all(
  //                       AdaptiveLayout.getResponsiveFontSize(
  //                         context,
  //                         fontSize: 12,
  //                       ),
  //                     ),
  //                     decoration: BoxDecoration(
  //                       color: AppColors.primary(
  //                         context,
  //                       ).withValues(alpha: 0.08),
  //                       borderRadius: BorderRadius.circular(
  //                         AdaptiveLayout.getResponsiveFontSize(
  //                           context,
  //                           fontSize: 12,
  //                         ),
  //                       ),
  //                     ),
  //                     child: Icon(
  //                       size: AdaptiveLayout.getResponsiveFontSize(
  //                         context,
  //                         fontSize: 24,
  //                       ),
  //                       LucideIcons.messageSquare,
  //                       color: AppColors.primary(context),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }

  //   return const SizedBox();
  // }
}
