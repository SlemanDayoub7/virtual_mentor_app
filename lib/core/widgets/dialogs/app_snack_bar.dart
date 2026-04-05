import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';

class AppSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(_icon(type), color: AppColors.white, size: AppSizes.iconMd),
            SizedBox(width: AppSizes.sm),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.bodyM(color: AppColors.white),
              ),
            ),
          ],
        ),
        backgroundColor: _color(type),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
        margin: EdgeInsets.all(AppSizes.lg),
      ),
    );
  }

  static void success(BuildContext context, String message) =>
      show(context: context, message: message, type: SnackBarType.success);

  static void error(BuildContext context, String message) =>
      show(context: context, message: message, type: SnackBarType.error);

  static void warning(BuildContext context, String message) =>
      show(context: context, message: message, type: SnackBarType.warning);

  static void info(BuildContext context, String message) =>
      show(context: context, message: message, type: SnackBarType.info);

  static Color _color(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return AppColors.success;
      case SnackBarType.error:
        return AppColors.error;
      case SnackBarType.warning:
        return AppColors.error;
      case SnackBarType.info:
        return AppColors.primary;
    }
  }

  static IconData _icon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle_outline_rounded;
      case SnackBarType.error:
        return Icons.error_outline_rounded;
      case SnackBarType.warning:
        return Icons.warning_amber_rounded;
      case SnackBarType.info:
        return Icons.info_outline_rounded;
    }
  }
}

enum SnackBarType { success, error, warning, info }
