import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';

enum AppButtonType { primary, secondary, outline, text, danger }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final AppButtonType type;
  final bool isLoading;
  final bool isFullWidth;
  final double? width;
  final double? height;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? borderRadius;

  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.isFullWidth = true,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height ?? AppSizes.buttonHeight,
      child: _buildButton(isDark),
    );
  }

  Widget _buildButton(bool isDark) {
    switch (type) {
      case AppButtonType.primary:
        return _PrimaryButton(
          label: label,
          onTap: onTap,
          isLoading: isLoading,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          borderRadius: borderRadius,
        );
      case AppButtonType.secondary:
        return _SecondaryButton(
          label: label,
          onTap: onTap,
          isLoading: isLoading,
          prefixIcon: prefixIcon,
          borderRadius: borderRadius,
        );
      case AppButtonType.outline:
        return _OutlineButton(
          label: label,
          onTap: onTap,
          isLoading: isLoading,
          prefixIcon: prefixIcon,
          borderRadius: borderRadius,
        );
      case AppButtonType.text:
        return _TextButton(label: label, onTap: onTap, prefixIcon: prefixIcon);
      case AppButtonType.danger:
        return _DangerButton(
          label: label,
          onTap: onTap,
          isLoading: isLoading,
          borderRadius: borderRadius,
        );
    }
  }
}

// ─── Primary ──────────────────────────────────────────────────────────────────
class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? borderRadius;

  const _PrimaryButton({
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppSizes.buttonRadius,
          ),
        ),
      ),
      child:
          isLoading
              ? SizedBox(
                width: 22.w,
                height: 22.w,
                child: const CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2.5,
                ),
              )
              : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    Icon(prefixIcon, size: AppSizes.iconMd),
                    SizedBox(width: AppSizes.sm),
                  ],
                  Text(label, style: AppTextStyles.button()),
                  if (suffixIcon != null) ...[
                    SizedBox(width: AppSizes.sm),
                    Icon(suffixIcon, size: AppSizes.iconMd),
                  ],
                ],
              ),
    );
  }
}

// ─── Secondary ────────────────────────────────────────────────────────────────
class _SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final IconData? prefixIcon;
  final double? borderRadius;

  const _SecondaryButton({
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.prefixIcon,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppSizes.buttonRadius,
          ),
        ),
      ),
      child:
          isLoading
              ? SizedBox(
                width: 22.w,
                height: 22.w,
                child: const CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2.5,
                ),
              )
              : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    Icon(prefixIcon, size: AppSizes.iconMd),
                    SizedBox(width: AppSizes.sm),
                  ],
                  Text(label, style: AppTextStyles.button()),
                ],
              ),
    );
  }
}

// ─── Outline ──────────────────────────────────────────────────────────────────
class _OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final IconData? prefixIcon;
  final double? borderRadius;

  const _OutlineButton({
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.prefixIcon,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return OutlinedButton(
      onPressed: isLoading ? null : onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppSizes.buttonRadius,
          ),
        ),
      ),
      child:
          isLoading
              ? SizedBox(
                width: 22.w,
                height: 22.w,
                child: const CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2.5,
                ),
              )
              : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    Icon(prefixIcon, size: AppSizes.iconMd),
                    SizedBox(width: AppSizes.sm),
                  ],
                  Text(
                    label,
                    style: AppTextStyles.button(color: AppColors.primary),
                  ),
                ],
              ),
    );
  }
}

// ─── Text ─────────────────────────────────────────────────────────────────────
class _TextButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? prefixIcon;

  const _TextButton({
    required this.label,
    required this.onTap,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null) ...[
            Icon(prefixIcon, size: AppSizes.iconMd, color: AppColors.primary),
            SizedBox(width: AppSizes.sm),
          ],
          Text(label, style: AppTextStyles.button(color: AppColors.primary)),
        ],
      ),
    );
  }
}

// ─── Danger ───────────────────────────────────────────────────────────────────
class _DangerButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final double? borderRadius;

  const _DangerButton({
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.error,
        foregroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppSizes.buttonRadius,
          ),
        ),
      ),
      child:
          isLoading
              ? SizedBox(
                width: 22.w,
                height: 22.w,
                child: const CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2.5,
                ),
              )
              : Text(label, style: AppTextStyles.button()),
    );
  }
}
