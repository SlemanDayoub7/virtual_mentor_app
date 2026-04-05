import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../extensions/extensions.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';

// ─── AppLoader ────────────────────────────────────────────────────────────────
class AppLoader extends StatelessWidget {
  final Color? color;
  final double size;

  const AppLoader({super.key, this.color, this.size = 32});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color ?? AppColors.primary,
          strokeWidth: 2.5,
        ),
      ),
    );
  }
}

// ─── AppShimmer ───────────────────────────────────────────────────────────────
class AppShimmer extends StatelessWidget {
  final Widget child;

  const AppShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.darkSurfaceVariant : AppColors.grey200,
      highlightColor: isDark ? AppColors.darkBorder : AppColors.grey100,
      child: child,
    );
  }
}

// ─── AppShimmerBox ────────────────────────────────────────────────────────────
class AppShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double? borderRadius;

  const AppShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(borderRadius ?? AppSizes.radiusMd),
        ),
      ),
    );
  }
}

// ─── AppShimmerCard ───────────────────────────────────────────────────────────
class AppShimmerCard extends StatelessWidget {
  const AppShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Container(
        margin: EdgeInsets.only(bottom: AppSizes.vlg),
        padding: EdgeInsets.all(AppSizes.lg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: AppSizes.avatarMd,
                  height: AppSizes.avatarMd,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: AppSizes.md),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 120, height: 14, color: Colors.white),
                    SizedBox(height: AppSizes.vsm),
                    Container(
                        width: 80, height: 12, color: Colors.white),
                  ],
                ),
              ],
            ),
            SizedBox(height: AppSizes.vlg),
            Container(
                width: double.infinity, height: 12, color: Colors.white),
            SizedBox(height: AppSizes.vsm),
            Container(width: 200, height: 12, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

// ─── AppShimmerList ───────────────────────────────────────────────────────────
class AppShimmerList extends StatelessWidget {
  final int itemCount;

  const AppShimmerList({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (_, __) => const AppShimmerCard(),
    );
  }
}
