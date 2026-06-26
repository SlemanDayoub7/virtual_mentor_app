import 'package:flutter/material.dart';
import '../../extensions/extensions.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';
import '../buttons/app_button.dart';

class AppDialog {
  static Future<bool?> confirm({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmLabel,
    String? cancelLabel,
    bool isDanger = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder:
          (_) => _AppDialogWidget(
            title: title,
            message: message,
            confirmLabel: confirmLabel ?? context.tr.confirm,
            cancelLabel: cancelLabel ?? context.tr.cancel,
            isDanger: isDanger,
          ),
    );
  }

  static Future<void> info({
    required BuildContext context,
    required String title,
    required String message,
    String? buttonLabel,
  }) {
    return showDialog(
      context: context,
      builder:
          (_) => _AppDialogWidget(
            title: title,
            message: message,
            confirmLabel: buttonLabel ?? context.tr.done,
            showCancel: false,
          ),
    );
  }

  static Future<void> error({
    required BuildContext context,
    required String message,
  }) {
    return showDialog(
      context: context,
      builder:
          (_) => _AppDialogWidget(
            title: context.tr.errorGeneral,
            message: message,
            confirmLabel: context.tr.retry,
            showCancel: false,
            isDanger: true,
          ),
    );
  }
}

class _AppDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String? cancelLabel;
  final bool showCancel;
  final bool isDanger;

  const _AppDialogWidget({
    required this.title,
    required this.message,
    required this.confirmLabel,
    this.cancelLabel,
    this.showCancel = true,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isDanger
                  ? Icons.error_outline_rounded
                  : Icons.info_outline_rounded,
              color: isDanger ? AppColors.error : AppColors.primary,
              size: AppSizes.iconXxl,
            ),
            SizedBox(height: AppSizes.vlg),
            Text(
              title,
              style: AppTextStyles.headingS(color: context.textPrimaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSizes.vsm),
            Text(
              message,
              style: AppTextStyles.bodyM(color: context.textSecondaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSizes.vxxl),
            Row(
              children: [
                if (showCancel) ...[
                  Expanded(
                    child: AppButton(
                      label: cancelLabel ?? context.tr.cancel,
                      onTap: () => Navigator.of(context).pop(false),
                      type: AppButtonType.outline,
                    ),
                  ),
                  SizedBox(width: AppSizes.md),
                ],
                Expanded(
                  child: AppButton(
                    label: confirmLabel,
                    onTap: () => Navigator.of(context).pop(true),
                    type:
                        isDanger ? AppButtonType.danger : AppButtonType.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
