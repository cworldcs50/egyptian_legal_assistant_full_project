import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../bloc/settings_bloc.dart';
import 'widgets/custom_footer.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'widgets/custom_list_tile.dart';
import 'widgets/custom_switch_tile.dart';
import 'widgets/custom_section_title.dart';
import '../../../core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/widgets/adaptive_layout.dart';
import '../../../core/widgets/app_state_widget.dart';
import '../../../core/theme/cubit/theme_cubit.dart';
import '../../../../core/services/service_locator.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsBloc = sl<SettingsBloc>();
    return BlocProvider(
      create: (_) => settingsBloc..add(LoadSettingsEvent(context)),
      child: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
          if (state.isSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('تمت العملية بنجاح')));
          }
        },
        builder: (context, state) {
          return Directionality(
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
                  'الإعدادات',
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
                    AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 1.0,
                    ),
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
              body: Builder(
                builder: (context) {
                  if (state.isLoading) {
                    return const AppStateWidget.loading();
                  }
                  if (state.errorMessage != null) {
                    return AppStateWidget.serverFailure(
                      message: state.errorMessage,
                      onRetry:
                          () => settingsBloc.add(LoadSettingsEvent(context)),
                    );
                  }
                  return LiquidPullToRefresh(
                    onRefresh: () async {
                      settingsBloc.add(LoadSettingsEvent(context));
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
                        const CustomSectionTitle(title: 'إعدادات عامة'),
                        SizedBox(
                          height: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 12.0,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.card(context),
                            borderRadius: BorderRadius.circular(
                              AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 12.0,
                              ),
                            ),
                            border: Border.all(
                              color: AppColors.border(context),
                              width: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 1.0,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              CustomSwitchTile(
                                title: 'الإشعارات',
                                subtitle: 'تلقي إشعارات عن الردود الجديدة',
                                icon: LucideIcons.bell,
                                value: state.notificationsEnabled,
                                onChanged: (val) {
                                  settingsBloc.add(
                                    ToggleNotificationsEvent(val),
                                  );
                                },
                              ),
                              Divider(
                                height: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 1.0,
                                ),
                                thickness: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 1.0,
                                ),
                                color: AppColors.border(context),
                              ),
                              const CustomListTile(
                                title: 'اللغة',
                                subtitle: 'العربية',
                                icon: LucideIcons.globe,
                              ),
                              Divider(
                                height: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 1.0,
                                ),
                                thickness: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 1.0,
                                ),
                                color: AppColors.border(context),
                              ),
                              CustomSwitchTile(
                                title: 'الوضع الليلي',
                                subtitle:
                                    state.isDarkMode ? 'مفعل' : 'غير مفعل',
                                icon: LucideIcons.moon,
                                value: state.isDarkMode,
                                onChanged: (val) async {
                                  settingsBloc.add(ToggleThemeEvent(val));
                                  // Also update the global ThemeCubit to apply the change immediately
                                  await context.read<ThemeCubit>().toggleTheme(
                                    val,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 32,
                          ),
                        ),
                        const CustomSectionTitle(title: 'البيانات والخصوصية'),
                        SizedBox(
                          height: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.card(context),
                            borderRadius: BorderRadius.circular(
                              AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 12,
                              ),
                            ),
                            border: Border.all(
                              color: AppColors.border(context),
                              width: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 1,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              CustomListTile(
                                title: 'مسح المحادثات',
                                subtitle: 'حذف جميع المحادثات السابقة',
                                icon: LucideIcons.trash2,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          backgroundColor: AppColors.card(
                                            context,
                                          ),
                                          title: Text(
                                            'مسح جميع المحادثات',
                                            style: TextStyle(
                                              color: AppColors.primary(context),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          content: Text(
                                            'هل أنت متأكد من مسح جميع المحادثات السابقة؟ هذا الإجراء لا يمكن التراجع عنه.',
                                            style: TextStyle(
                                              color: AppColors.foreground(
                                                context,
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                  context,
                                                ); // Close dialog
                                              },
                                              child: Text(
                                                'إلغاء',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.mutedForeground(
                                                        context,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                  context,
                                                ); // Close dialog
                                                settingsBloc.add(
                                                  ClearConversationsEvent(),
                                                );
                                              },
                                              child: const Text(
                                                'مسح',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              Divider(
                                height: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 1,
                                ),
                                thickness: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 1,
                                ),
                                color: AppColors.border(context),
                              ),
                              const CustomListTile(
                                title: 'سياسة الخصوصية',
                                subtitle: 'اطلع على سياسة الخصوصية',
                                icon: LucideIcons.helpCircle,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 32,
                          ),
                        ),
                        const CustomFooter(),
                        SizedBox(
                          height: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 32,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
