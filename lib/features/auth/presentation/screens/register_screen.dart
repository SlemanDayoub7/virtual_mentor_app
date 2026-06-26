// lib/features/auth/presentation/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/router/app_router.dart';
import 'package:virtual_mentor_app/core/utils/validators.dart';
import 'package:virtual_mentor_app/core/widgets/buttons/app_button.dart';
import 'package:virtual_mentor_app/core/widgets/dialogs/app_snack_bar.dart';
import 'package:virtual_mentor_app/core/widgets/text_fields/app_text_field.dart';
import 'package:virtual_mentor_app/features/auth/presentation/blocs/register_bloc.dart';
import 'package:virtual_mentor_app/features/auth/presentation/widgets/auth_background_shape_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_assets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _birthDateController = TextEditingController();
  String? _selectedGender;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text = picked.toIso8601String().split('T')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          // Pass email to OTP screen via extra
          context.push(AppRoutes.otp, extra: _emailController.text.trim());
        } else if (state is RegisterFailure) {
          AppSnackBar.error(context, state.message);
        }
      },

      child: Scaffold(
        backgroundColor: AppColors.screenBackground,
        body: SizedBox(
          width: AppSizes.designWidth.w,
          height: AppSizes.designHeight.h,
          child: Stack(
            children: [
              const AuthBackgroundShapeWidget(),
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 26.w),
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
                              AppAssets.register,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: AppSizes.lg),
                        Text(
                          context.tr.createANewAccount,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.displayBold(
                            color: context.textPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          context.tr.registerBeginlearning,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.labelRegular().copyWith(
                            color: context.textSecondaryColor,
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Full Name
                        AppTextField(
                          controller: _nameController,
                          label: context.tr.fullName,
                          hint: context.tr.enterFullname,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          validator: (value) => context.validateFullName(value),
                        ),
                        SizedBox(height: AppSizes.md),

                        // Email
                        AppTextField(
                          controller: _emailController,
                          label: context.tr.email,
                          hint: context.tr.enterEmailAddress,
                          suffixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) => context.validateEmail(value),
                        ),

                        SizedBox(height: AppSizes.md),

                        // Password
                        AppTextField(
                          controller: _passwordController,
                          label: context.tr.password,
                          hint: context.tr.enterPassword,
                          isPassword: true,
                          textInputAction: TextInputAction.next,
                          validator: (value) => context.validatePassword(value),
                        ),
                        SizedBox(height: AppSizes.md),

                        // Confirm Password
                        AppTextField(
                          controller: _confirmPasswordController,
                          label: context.tr.confirmPassword,
                          hint: context.tr.confirmPassword,
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          validator:
                              (value) => context.validateConfirmPassword(
                                value,
                                _passwordController.text,
                              ),
                        ),
                        SizedBox(height: AppSizes.md),

                        // Terms and Conditions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                value: _agreeToTerms,
                                checkColor: AppColors.primary,
                                fillColor: WidgetStateProperty.all(
                                  AppColors.white,
                                ),
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
                            SizedBox(width: 6.w),
                            Text(
                              context.tr.agree,
                              style: AppTextStyles.bodyM(
                                color: context.textPrimaryColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                context.tr.termsAndConditions,
                                style: AppTextStyles.bodyM(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.lg),

                        // Register Button
                        BlocBuilder<RegisterBloc, RegisterState>(
                          builder: (context, state) {
                            return AppButton(
                              label: context.tr.register,
                              type: AppButtonType.primary,
                              isLoading: state is RegisterLoading,
                              onTap: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  if (!_agreeToTerms) {
                                    AppSnackBar.warning(
                                      context,
                                      'You must agree to terms',
                                    );
                                    return;
                                  }

                                  final nameParts = _nameController.text
                                      .trim()
                                      .split(' ');
                                  final firstName = nameParts.first;
                                  final lastName =
                                      nameParts.length > 1
                                          ? nameParts.skip(1).join(' ')
                                          : '';

                                  context.read<RegisterBloc>().add(
                                    RegisterSubmitted(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text,
                                      firstName: firstName,
                                      lastName: lastName,
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                        SizedBox(height: AppSizes.md),

                        // Login Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context.tr.haveAnAccount,
                              style: AppTextStyles.bodyM(
                                color: context.textSecondaryColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                context.tr.login,
                                style: AppTextStyles.bodyM(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.md),

                        // OR Divider
                        Center(
                          child: Text(
                            context.tr.or,
                            style: AppTextStyles.bodyS(
                              color: context.textSecondaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: AppSizes.md),

                        // Google Login Button
                        // BlocBuilder<GoogleLoginCubit, GoogleLoginState>(
                        //   builder: (context, state) {
                        //     return LoginWithGoogleButton(
                        //       isLoading: state is GoogleLoginLoading,
                        //       onTap: () {
                        //         // TODO: Implement Google Sign-In
                        //       },
                        //     );
                        //   },
                        // ),
                        SizedBox(height: AppSizes.xl),
                      ],
                    ),
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
