import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/core/utils/app_assets.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    super.key,
    required this.materialsCount,
    required this.achievementPercent,
    required this.testsCount,
  });

  final int materialsCount;
  final int achievementPercent;
  final int testsCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCell(
            svgAsset: AppAssets.book,
            label: 'المواد',
            value: '$materialsCount',
          ),
        ),
        _Divider(),
        Expanded(
          child: _StatCell(
            svgAsset: AppAssets.achievement,
            label: 'الإنجاز',
            value: '$achievementPercent%',
          ),
        ),
        _Divider(),
        Expanded(
          child: _StatCell(
            svgAsset: AppAssets.quiz,
            label: 'الاختبارات',
            value: '$testsCount',
          ),
        ),
      ],
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.svgAsset,
    required this.label,
    required this.value,
  });

  final String svgAsset;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSizes.vsm),
      decoration: BoxDecoration(
        color: context.cardBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            svgAsset,
            width: 22.r,
            height: 22.r,
            colorFilter: ColorFilter.mode(
              context.primaryColor,
              BlendMode.srcIn,
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
          Text(value, style: AppTextStyles.labelRegular()),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: AppSizes.sm);
  }
}
