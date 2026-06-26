// lib/features/auth/presentation/screens/account_verification_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/router/app_router.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/core/utils/app_assets.dart';
import 'package:virtual_mentor_app/core/widgets/buttons/app_button.dart';
import 'package:virtual_mentor_app/core/widgets/dialogs/app_snack_bar.dart';
import 'package:virtual_mentor_app/features/auth/presentation/blocs/otp_bloc.dart';
import 'package:virtual_mentor_app/features/auth/presentation/screens/custom_otp_fields.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void _verify() {
    final code = otpController.text.trim();
    if (code.isEmpty) return;
    context.read<OtpBloc>().add(
      OtpVerifySubmitted(email: widget.email, code: code),
    );
  }

  void _resend() {
    context.read<OtpBloc>().add(OtpResendRequested(widget.email));
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return BlocConsumer<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is OtpVerified) {
          // Account activated — navigate to login
          context.go(AppRoutes.login);
          AppSnackBar.success(
            context,
            'Account verified successfully! Please log in.',
          );
        } else if (state is OtpResent) {
          AppSnackBar.info(context, state.message);
        } else if (state is OtpFailure) {
          AppSnackBar.error(context, state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is OtpLoading;
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
                LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
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
                              SizedBox(
                                height: isKeyboardOpen ? 20.h : AppSizes.vxxxl,
                              ),

                              // OTP Fields
                              CustomOtpFields(
                                length: 6,
                                controller: otpController,
                                onCompleted: (pin) {},
                              ),

                              // Resend OTP Link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    context.tr.noAccount,
                                    style: AppTextStyles.labelRegular(),
                                  ),
                                  GestureDetector(
                                    onTap: isLoading ? null : _resend,
                                    child: Text(
                                      context.tr.reSend,
                                      style: AppTextStyles.bodyM(
                                        color:
                                            isLoading
                                                ? AppColors.grey400
                                                : AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppSizes.vxxxl),

                              AppButton(
                                label: context.tr.confirm,
                                type: AppButtonType.primary,
                                isLoading: isLoading,
                                onTap: () {
                                  if (otpController.text.length == 6) {
                                    _verify();
                                  } else {
                                    AppSnackBar.warning(
                                      context,
                                      'Please enter complete OTP',
                                    );
                                  }
                                },
                              ),
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
      },
    );
  }
}
