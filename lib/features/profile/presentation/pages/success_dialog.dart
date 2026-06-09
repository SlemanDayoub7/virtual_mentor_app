import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
       Container(
  width: 106.w,
  height: 106.h,
  decoration: const BoxDecoration(
    color: AppColors.white,
    shape: BoxShape.circle,),
  child:  Icon(Icons.check,
    color: AppColors.success,
    size:60.w
    )),
       SizedBox(height: 20.h),
          Container(
            width: 342.w,
            height: 111.h,
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(12),
            ),
            child:  Center(
              child: Text(
                context.tr.saveInfo,
                style:AppTextStyles.titleMedium(color: AppColors.white)
              ),
            ),
          ),
        ],
      ),
    );
  }
}