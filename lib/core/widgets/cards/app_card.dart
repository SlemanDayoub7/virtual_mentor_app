import 'package:flutter/material.dart';
import '../../extensions/extensions.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';

// ─── AppCard ──────────────────────────────────────────────────────────────────
class AppCard extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final bool showBorder;

  const AppCard({
    super.key,
    required this.child,
    this.borderRadius,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.onTap,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppSizes.cardRadius;
    final bg = backgroundColor ?? context.surfaceColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding ?? EdgeInsets.all(AppSizes.cardPadding),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder
              ? Border.all(color: context.borderColor, width: 1)
              : null,
        ),
        child: child,
      ),
    );
  }
}

// ─── AppGradientContainer ─────────────────────────────────────────────────────
class AppGradientContainer extends StatelessWidget {
  final Widget child;
  final LinearGradient? gradient;
  final double? borderRadius;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  const AppGradientContainer({
    super.key,
    required this.child,
    this.gradient,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding ?? EdgeInsets.all(AppSizes.lg),
        decoration: BoxDecoration(
          gradient: gradient ?? AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppSizes.cardRadius,
          ),
        ),
        child: child,
      ),
    );
  }
}

// ─── AppSpacer ────────────────────────────────────────────────────────────────
class AppSpacer extends StatelessWidget {
  final double? height;
  final double? width;

  const AppSpacer.vertical(double this.height, {super.key}) : width = null;
  const AppSpacer.horizontal(double this.width, {super.key}) : height = null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height);
  }
}

// ─── AppDivider ───────────────────────────────────────────────────────────────
class AppDivider extends StatelessWidget {
  final double? indent;
  final Color? color;

  const AppDivider({super.key, this.indent, this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? context.dividerColor,
      thickness: 1,
      indent: indent,
      endIndent: indent,
    );
  }
}

// ─── AppBadge ─────────────────────────────────────────────────────────────────
class AppBadge extends StatelessWidget {
  final String? count;
  final Widget child;
  final Color? color;

  const AppBadge({
    super.key,
    required this.child,
    this.count,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        if (count != null)
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: color ?? AppColors.error,
                shape: BoxShape.circle,
              ),
              child: Text(
                count!,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
