import 'adaptive_layout.dart';
import 'app_lottie_widget.dart';
import '../theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../constants/app_lotties.dart';

enum AppStateType { loading, noInternet, serverFailure, databaseError, empty }

/// A reusable widget that renders the correct Lottie animation
/// for loading / error / empty states, respecting light & dark mode.
class AppStateWidget extends StatelessWidget {
  final AppStateType type;
  final String? message;
  final VoidCallback? onRetry;

  const AppStateWidget({
    super.key,
    required this.type,
    this.message,
    this.onRetry,
  });

  /// Convenience constructors
  const AppStateWidget.loading({super.key})
    : type = AppStateType.loading,
      message = null,
      onRetry = null;

  const AppStateWidget.noInternet({super.key, this.message, this.onRetry})
    : type = AppStateType.noInternet;

  const AppStateWidget.serverFailure({super.key, this.message, this.onRetry})
    : type = AppStateType.serverFailure;

  const AppStateWidget.databaseError({super.key, this.message, this.onRetry})
    : type = AppStateType.databaseError;

  const AppStateWidget.empty({super.key, this.message, this.onRetry})
    : type = AppStateType.empty;

  String get _lottiePath {
    switch (type) {
      case AppStateType.loading:
        return AppLotties.loading;
      case AppStateType.noInternet:
        return AppLotties.offline;
      case AppStateType.serverFailure:
        return AppLotties.serverFailure;
      case AppStateType.databaseError:
        return AppLotties.fail;
      case AppStateType.empty:
        return AppLotties.fail;
    }
  }

  String get _defaultMessage {
    switch (type) {
      case AppStateType.loading:
        return 'جاري التحميل...';
      case AppStateType.noInternet:
        return 'لا يوجد اتصال بالإنترنت';
      case AppStateType.serverFailure:
        return 'حدث خطأ في الخادم';
      case AppStateType.databaseError:
        return 'خطأ في قاعدة البيانات';
      case AppStateType.empty:
        return 'لا توجد بيانات';
    }
  }

  bool get _isLoading => type == AppStateType.loading;

  @override
  Widget build(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;
    final double lottieSize = AdaptiveLayout.getResponsiveFontSize(
      context,
      fontSize: 220,
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLottieWidget(
            lottiePath: _lottiePath,
            width: lottieSize,
            height: lottieSize,
            fit: BoxFit.contain,
            repeat: _isLoading,
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
          ),
          Text(
            message ?? _defaultMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color:
                  _isLoading
                      ? AppColors.mutedForeground(context)
                      : AppColors.foreground(context),
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 15,
              ),
              height: 1.5,
            ),
          ),
          if (onRetry != null && !_isLoading) ...[
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 24,
              ),
            ),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary(context),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 24,
                  ),
                  vertical: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 12,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
                  ),
                ),
              ),
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة المحاولة'),
            ),
          ],
        ],
      ),
    );
  }
}
