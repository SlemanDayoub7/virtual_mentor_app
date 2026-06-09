import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/core/utils/app_assets.dart';
import 'package:virtual_mentor_app/core/widgets/buttons/app_button.dart';
import 'package:virtual_mentor_app/features/verification/presentaion/pages/custom-otp-fields.dart';
// ignore_for_file: prefer_const_constructors



class ReturnAccountScreen extends StatefulWidget {
  const ReturnAccountScreen({super.key});

  @override
  State<ReturnAccountScreen> createState() => _ReturnAccountScreenState();
}

class _ReturnAccountScreenState extends State<ReturnAccountScreen> {
   final otpController = TextEditingController();
  @override
   void dispose() {
    otpController.dispose();
    super.dispose();
  }
  // ignore: annotate_overrides
  Widget build(BuildContext context) {
     final isKeyboardOpen =
        MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      resizeToAvoidBottomInset: true, // يتقلص الـ Scaffold تلقائياً بشكل آمن
      body: SafeArea(
        child: Stack(
          children: [
            // خلفية الـ SVG
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
            // حساب المساحة المتاحة بدقة
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const ClampingScrollPhysics(), 
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.vxxl), 
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              margin: EdgeInsets.only(
                                top: isKeyboardOpen ? 15.h : AppSizes.vxxxl,
                                bottom: 26.h,
                              ),
                              width: isKeyboardOpen ? 180.w : 332.w,
                              height: isKeyboardOpen ? 160.h : 317.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Image.asset(
                                AppAssets.reVerf,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text(
                            context.tr.reSendCode,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.displayBold(),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            context.tr.cheakEmail,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyRegular(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: isKeyboardOpen ? 20.h : AppSizes.vxxxl),
                          CustomOtpFields(
                            length: 4,
                            controller: otpController,
                            onCompleted: (pin) {
                              // دالة التحقق من الرمز
                            },
                          ),
                          
                          SizedBox(height: 15.h),
                          
                          // نص إعادة الإرسال
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                context.tr.noAccount,
                                style: AppTextStyles.labelRegular(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // TODO: register navigation
                                },
                                child: Text(
                                  context.tr.reSend,
                                  style: AppTextStyles.bodyM(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          AppButton(
                            label: context.tr.confirm,
                            type: AppButtonType.primary,
                            onTap: () {},
                          ),
                          
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}