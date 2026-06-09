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
class AccountVerficationScreen extends StatefulWidget {
  const AccountVerficationScreen({super.key});

  @override
  State<AccountVerficationScreen> createState() => _AccountVerficationScreenState();
}

class _AccountVerficationScreenState extends State<AccountVerficationScreen> {
  final otpController = TextEditingController();
  @override
    void dispose() {
    otpController.dispose();
    super.dispose();
  }
  // ignore: annotate_overrides
  Widget build(BuildContext context) {
      final isKeyboardOpen =MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
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
            LayoutBuilder(builder: (context, constraints){
              return SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const ClampingScrollPhysics(), 
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.vxxl), 
                  child: ConstrainedBox(constraints: 
                  BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),child: IntrinsicHeight(
                      child:
                       Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 Center(
                      child:
                      AnimatedContainer(
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
                                AppAssets.accountVerf,
                                fit: BoxFit.contain,
                              ),
                            ),
                    ),
                  Text(
                    context.tr.checkAccount,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.displayBold(),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    context.tr.enterCode,
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
                // هنا يمكنك استدعاء دالة التحقق من الرمز فوراٌ
              },
            ),
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
                        SizedBox(height: AppSizes.vxxxl),
                        AppButton(
                        label: context.tr.confirm,
                        type: AppButtonType.primary,
                        onTap: () {},
                  ),
              ],
            )
                       ,
                    ),
                  ),
              );
            }
            ),
           
          ],
        ),
      ),
    );
  }
}