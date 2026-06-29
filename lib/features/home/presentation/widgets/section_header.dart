import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onActionTap,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.titleMedium()),
        GestureDetector(
          onTap: onActionTap,
          child: Row(
            children: [
              Text(
                actionLabel,
                style: AppTextStyles.bodyRegular(color: context.primaryColor),
              ),
              Icon(
                Icons.chevron_right,
                size: 16.r,
                color: context.primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
