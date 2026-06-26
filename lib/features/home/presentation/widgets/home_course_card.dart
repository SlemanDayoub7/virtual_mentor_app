import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';

class HomeCourseCard extends StatelessWidget {
  const HomeCourseCard({
    super.key,
    required this.svgAsset,
    required this.title,
    required this.subtitle,
    required this.completedLessons,
    required this.totalLessons,
    required this.progressPercent,
    required this.statusLabel,
    required this.isComplete,
  });

  final String svgAsset;
  final String title;
  final String subtitle;
  final int completedLessons;
  final int totalLessons;
  final double progressPercent;
  final String statusLabel;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: context.cardBackgroundColor,
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          border: Border.all(color: context.borderColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon box
            Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                color: context.skyBlueColor,
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: Center(
                child: SvgPicture.asset(
                  svgAsset,
                  width: 24.r,
                  height: 24.r,
                  colorFilter: ColorFilter.mode(
                    context.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(width: AppSizes.sm),
            // Text + progress
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyles.bodyRegular(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (statusLabel.isNotEmpty)
                        _StatusBadge(
                          label: statusLabel,
                          isComplete: isComplete,
                        ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: AppTextStyles.captionRegular(
                      color: context.textSecondaryColor,
                    ),
                  ),
                  SizedBox(height: AppSizes.vsm),
                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: LinearProgressIndicator(
                      value: progressPercent,
                      minHeight: 6.h,
                      backgroundColor: context.borderColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isComplete ? context.successColor : context.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '$completedLessons من $totalLessons مقارات',
                    style: AppTextStyles.captionRegular(
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, required this.isComplete});

  final String label;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    final color = isComplete ? context.successColor : context.textHintColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Text(
        label,
        style: AppTextStyles.captionRegular(color: color),
      ),
    );
  }
}
