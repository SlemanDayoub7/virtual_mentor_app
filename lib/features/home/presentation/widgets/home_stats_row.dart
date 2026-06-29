import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';

class HomeStatsRow extends StatelessWidget {
  const HomeStatsRow({
    super.key,
    required this.materialsCount,
    required this.achievementPercent,
    required this.xp,
  });

  final int materialsCount;
  final double achievementPercent;
  final int xp;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              svgAsset: 'assets/icons/ic_book.svg',
              label: 'المواد',
              value: '$materialsCount',
            ),
          ),
          SizedBox(width: AppSizes.sm),
          Expanded(
            child: _StatCard(
              svgAsset: 'assets/icons/ic_achievement.svg',
              label: 'الإنجاز',
              value: '$achievementPercent%',
            ),
          ),
          SizedBox(width: AppSizes.sm),
          Expanded(
            child: _StatCard(
              svgAsset: 'assets/icons/ic_quiz.svg',
              label: 'Xp',
              value: '$xp',
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.svgAsset,
    required this.label,
    required this.value,
  });

  final String svgAsset;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.sm,
            horizontal: AppSizes.sm,
          ),
          decoration: BoxDecoration(
            color: context.cardBackgroundColor,
            // borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            border: Border.all(color: context.borderColor),
            shape: BoxShape.circle,
          ),
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
        SizedBox(height: 4.h),
        Text(
          label,
          style: AppTextStyles.captionRegular(
            color: context.textSecondaryColor,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.r, horizontal: 8.r),
          decoration: BoxDecoration(
            color: context.skyBlueColor,
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            border: Border.all(color: context.borderColor),
          ),
          child: Text(
            value,
            style: AppTextStyles.labelRegular(
              color: context.theme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
