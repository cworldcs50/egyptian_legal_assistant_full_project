import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_events.dart';
import '../bloc/history_states.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import '../../home/home/bloc/home_bloc.dart';
import '../../home/home/bloc/home_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/adaptive_layout.dart';
import '../../../core/widgets/app_state_widget.dart';

class CustomHistoryBody extends StatelessWidget {
  const CustomHistoryBody({super.key, required this.state});

  final HistoryStates state;

  @override
  Widget build(BuildContext context) {
    final historyBloc = context.read<HistoryBloc>();
    if (state is HistoryLoading) {
      return const AppStateWidget.loading();
    }

    if (state is HistoryError) {
      return AppStateWidget.databaseError(
        message: (state as HistoryError).errorModel.message,
        onRetry: () => historyBloc.add(const FetchSessionsEvent()),
      );
    }

    if (state is HistorySuccess) {
      final sessions = (state as HistorySuccess).sessions;

      if (sessions.isEmpty) {
        return AppStateWidget.empty(
          message: 'لا توجد محادثات سابقة',
          onRetry:
              () => context.read<HistoryBloc>().add(const FetchSessionsEvent()),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.all(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16.0),
        ),
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];
          final String title = session['title'] ?? 'محادثة جديدة';
          final String description = session['last_message'] ?? '';
          final DateTime date = DateTime.parse(session['updated_at']);
          final String formattedDate = intl.DateFormat(
            'd MMMM yyyy',
            'ar',
          ).format(date);

          return GestureDetector(
            onTap: () {
              context.read<HomeBloc>().add(LoadSessionEvent(session['id']));
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(
                bottom: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16.0,
                ),
              ),
              decoration: BoxDecoration(
                color: AppColors.card(context),
                borderRadius: BorderRadius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
                ),
                border: Border.all(
                  color: AppColors.ring(context).withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.primary(context),
                              fontWeight: FontWeight.bold,
                              fontSize: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 4,
                            ),
                          ),
                          Text(
                            description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.mutedForeground(context),
                              fontSize: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 8,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                LucideIcons.calendar,
                                color: AppColors.ring(context),
                                size: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                width: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 4,
                                ),
                              ),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  color: AppColors.ring(context),
                                  fontSize:
                                      AdaptiveLayout.getResponsiveFontSize(
                                        context,
                                        fontSize: 12,
                                      ),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(
                        AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 12,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary(
                          context,
                        ).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(
                          AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      child: Icon(
                        size: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 24,
                        ),
                        LucideIcons.messageSquare,
                        color: AppColors.primary(context),
                      ),
                    ),
                    SizedBox(
                      width: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 8,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(LucideIcons.trash2, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: AlertDialog(
                                backgroundColor: AppColors.card(context),
                                title: Text(
                                  'مسح المحادثة',
                                  style: TextStyle(
                                    color: AppColors.primary(context),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Text(
                                  'هل أنت متأكد من مسح هذه المحادثة؟',
                                  style: TextStyle(
                                    color: AppColors.foreground(context),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'إلغاء',
                                      style: TextStyle(
                                        color: AppColors.mutedForeground(
                                          context,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      historyBloc.add(
                                        DeleteSessionEvent(session['id']),
                                      );
                                    },
                                    child: const Text(
                                      'مسح',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return const SizedBox();
  }
}
