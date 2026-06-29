import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';

class HomeSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: context.cardBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: context.borderColor),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(width: AppSizes.md),
          Icon(Icons.search, color: context.textHintColor, size: 20.r),
          SizedBox(width: AppSizes.sm),
          Text(
            'ابحث في المواد ...',
            style: AppTextStyles.bodyRegular(color: context.textHintColor),
          ),
        ],
      ),
    );
  }
}
