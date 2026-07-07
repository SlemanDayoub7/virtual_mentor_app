import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';

class StatisticsCard extends StatelessWidget {
  final String title;
  final String value;
  const StatisticsCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
    decoration: BoxDecoration(
      color:AppColors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(
        color: AppColors.white.withValues(alpha: 0.2),
        width: 1.w,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: AppTextStyles.titleBold(),
        ),
        SizedBox(height: 6.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.captionRegular(
            color:AppColors.primary 
          ).copyWith(height: 1.2),
        ),
      ],
    ),
  );
  }
}

class StateCard extends StatelessWidget {
    final IconData icon;
    final Color iconColor;
    final Color iconBg;
    final String value;
    final String title;
  const StateCard({super.key, required this.icon, required this.iconColor, required this.iconBg, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105.w,
      height: 112.h,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: AppSizes.iconSm),
          ),
          SizedBox(height: 10.h),
          Text(
            value,
            style: AppTextStyles.titleBold(color: AppColors.textPrimary),
          ),
          SizedBox(height: 9.h),
          Text(
            title,
            style: AppTextStyles.captionMedium(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}