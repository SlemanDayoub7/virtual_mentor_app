// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/core/utils/app_assets.dart';
import 'package:virtual_mentor_app/core/widgets/buttons/app_button.dart';

class VerificationSuccessScreen extends StatelessWidget {
  const VerificationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: Center(
        child: SizedBox(
          width: AppSizes.designWidth.w,
          height: AppSizes.designHeight.h,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: SvgPicture.asset(
                  AppAssets.backgroundShape,
                  width: 57.w,
                  height: 1.sh,
                  fit: BoxFit.contain,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.only(start: AppSizes.pagePadding,end: AppSizes.pagePadding,
                      top: 93.h,bottom: 120.h ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          width: 332.w,
                          height: 400.h,
                          decoration: BoxDecoration(
                           color: Colors.white,
                             borderRadius: BorderRadius.circular(20.r),
                            ),
                          child: Image.asset(
                            AppAssets.success,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height:AppSizes.vhuge),
                      Text(
                        context.tr.accountVerified,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.displayBold(),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        context.tr.letsBegin,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyRegular(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: AppSizes.vxxxl,),
                      AppButton(
                        label: context.tr.startJourney,
                        type: AppButtonType.primary,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

