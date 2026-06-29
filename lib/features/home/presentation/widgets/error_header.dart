import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/features/home/presentation/widgets/home_greeting_header.dart';

class ErrorHeader extends StatelessWidget {
  const ErrorHeader({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        HomeGreetingHeader(
          greeting: 'مرحباً بك!',
          name: '...',
          specialty: '...',
        ),
        SizedBox(height: AppSizes.vsm),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.md,
            vertical: AppSizes.vmd,
          ),
          decoration: BoxDecoration(
            color: context.errorColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            border: Border.all(
              color: context.errorColor.withOpacity(0.3),
              width: 1.w,
            ),
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: context.errorColor,
                size: 24.r,
              ),
              SizedBox(width: AppSizes.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'تعذّر تحميل البيانات',
                      style: AppTextStyles.bodyBold(color: context.errorColor),
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      message,
                      style: AppTextStyles.captionRegular(
                        color: context.textSecondaryColor,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(height: AppSizes.vxs),
                    TextButton(
                      onPressed: onRetry,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'إعادة المحاولة',
                        style: AppTextStyles.bodyRegular(
                          color: context.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSizes.vxxxl),
      ],
    );
  }
}
