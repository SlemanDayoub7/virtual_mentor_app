import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../extensions/extensions.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';
import '../buttons/app_button.dart';

// ─── Base Error Widget ────────────────────────────────────────────────────────
class AppErrorWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final String? buttonLabel;
  final VoidCallback? onRetry;
  final IconData icon;
  final Color? iconColor;

  const AppErrorWidget({
    super.key,
    this.title,
    this.message,
    this.buttonLabel,
    this.onRetry,
    this.icon = Icons.error_outline_rounded,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppSizes.iconXxl,
              color: iconColor ?? AppColors.error,
            ),
            SizedBox(height: AppSizes.vlg),
            Text(
              title ?? context.tr.errorGeneral,
              style: AppTextStyles.headingS(color: context.textPrimaryColor),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              SizedBox(height: AppSizes.vsm),
              Text(
                message!,
                style: AppTextStyles.bodyM(color: context.textSecondaryColor),
                textAlign: TextAlign.center,
              ),
            ],
            if (onRetry != null) ...[
              SizedBox(height: AppSizes.vxxl),
              AppButton(
                label: buttonLabel ?? context.tr.retry,
                onTap: onRetry,
                isFullWidth: false,
                width: 160,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Network Error ────────────────────────────────────────────────────────────
class AppNetworkErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const AppNetworkErrorWidget({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return AppErrorWidget(
      title: context.tr.errorNetwork,
      message: context.tr.errorNetwork,
      icon: Icons.wifi_off_rounded,
      iconColor: AppColors.error,
      onRetry: onRetry,
    );
  }
}

// ─── Server Error ─────────────────────────────────────────────────────────────
class AppServerErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const AppServerErrorWidget({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return AppErrorWidget(
      title: context.tr.errorServer,
      message: context.tr.errorServer,
      icon: Icons.cloud_off_rounded,
      iconColor: AppColors.error,
      onRetry: onRetry,
    );
  }
}

// ─── Unauthorized Error ───────────────────────────────────────────────────────
class AppUnauthorizedWidget extends StatelessWidget {
  final VoidCallback? onLogin;

  const AppUnauthorizedWidget({super.key, this.onLogin});

  @override
  Widget build(BuildContext context) {
    return AppErrorWidget(
      title: context.tr.errorUnauthorized,
      message: context.tr.sessionExpired,
      icon: Icons.lock_outline_rounded,
      iconColor: AppColors.error,
      buttonLabel: context.tr.login,
      onRetry: onLogin,
    );
  }
}

// ─── Not Found Error ──────────────────────────────────────────────────────────
class AppNotFoundWidget extends StatelessWidget {
  final VoidCallback? onBack;

  const AppNotFoundWidget({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppErrorWidget(
      title: context.tr.errorNotFound,
      message: context.tr.errorNotFound,
      icon: Icons.search_off_rounded,
      iconColor: AppColors.grey400,
      buttonLabel: context.tr.back,
      onRetry: onBack ?? () => context.pop(),
    );
  }
}
