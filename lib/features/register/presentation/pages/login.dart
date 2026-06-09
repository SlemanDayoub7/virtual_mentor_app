import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/widgets/buttons/app_button.dart';
import 'package:virtual_mentor_app/core/widgets/text_fields/app_text_field.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_assets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SizedBox(
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
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: AppSizes.xl),
                      Center(
                        child: SizedBox(
                          width: 230.w,
                          height: 203.h,
                          child: Image.asset(
                            AppAssets.login,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSizes.lg),
                      Text(
                        context.tr.welcomeBack,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.displayBold(color: textColor),
                      ),
                      SizedBox(height: AppSizes.vsm),
                      Text(
                        context.tr.logToContinueJourney,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.labelRegular().copyWith(
                          color: secondaryTextColor,
                        ),
                      ),
                      SizedBox(height: AppSizes.vxxl),
                      AppTextField(
                        controller: _emailController,
                        label: context.tr.email,
                        hint: context.tr.enterEmailAddress,
                        suffixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: AppSizes.md),
                      AppTextField(
                        controller: _passwordController,
                        label: context.tr.password,
                        hint: context.tr.enterPassword,
                        isPassword: true,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: AppSizes.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: AppSizes.lg,
                            child: Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                value: _agreeToTerms,
                                checkColor: AppColors.primary,
                                fillColor:
                                    WidgetStateProperty.all(AppColors.white),
                                shape: const CircleBorder(),
                                side: const BorderSide(
                                  color: AppColors.white,
                                  width: 1.5,
                                ),
                                visualDensity: const VisualDensity(
                                  horizontal: -4.0,
                                  vertical: -4.0,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _agreeToTerms = value ?? false;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            context.tr.remamber,
                            style: AppTextStyles.bodyM(color: textColor),
                          ),
                          SizedBox(width: 150.w),
                          GestureDetector(
                            onTap: () {
                              // TODO: forgot password navigation
                            },
                            child: Text(
                              context.tr.forgotPassword,
                              style: AppTextStyles.bodyM(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.lg),
                      AppButton(
                        label: context.tr.login,
                        type: AppButtonType.primary,
                        onTap: () {},
                      ),
                      SizedBox(height: AppSizes.xxl),
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
                              context.tr.register,
                              style: AppTextStyles.bodyM(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.xxl),
                      Center(
                        child: Text(
                          context.tr.or,
                          style: AppTextStyles.bodyS(color: secondaryTextColor),
                        ),
                      ),
                      SizedBox(height: AppSizes.xxl),
                      AppButton(
                        label: context.tr.continueWith,
                        type: AppButtonType.outline,
                        onTap: () {},
                        prefixWidget: SizedBox(
                          width: 22.w,
                          height: 22.w,
                          child: SvgPicture.asset(
                            AppAssets.google,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSizes.xl),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

