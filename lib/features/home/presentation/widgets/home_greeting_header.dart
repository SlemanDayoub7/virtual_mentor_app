import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';

class HomeGreetingHeader extends StatelessWidget {
  const HomeGreetingHeader({
    super.key,
    required this.greeting,
    required this.name,
    required this.specialty,
  });

  final String greeting;
  final String name;
  final String specialty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text(
          greeting,
          style: AppTextStyles.bodyRegular(color: context.textSecondaryColor),
        ),
        SizedBox(height: 10.h),
        Text(name, style: AppTextStyles.titleBold()),
        SizedBox(height: 10.h),
        Row(
          children: [
            Container(
              width: 14.r,
              height: 14.r,
              decoration: BoxDecoration(
                color: context.skyBlueColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              specialty,
              style: AppTextStyles.titleMedium(
                color: context.textSecondaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
