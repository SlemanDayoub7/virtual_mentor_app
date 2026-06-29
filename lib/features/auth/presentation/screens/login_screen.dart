// lib/features/auth/presentation/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_mentor_app/core/bloc/session_bloc/session_bloc.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/router/app_router.dart';
import 'package:virtual_mentor_app/core/storage/secure_storage_helper.dart';
import 'package:virtual_mentor_app/core/utils/validators.dart';
import 'package:virtual_mentor_app/core/widgets/buttons/app_button.dart';
import 'package:virtual_mentor_app/core/widgets/dialogs/app_snack_bar.dart';
import 'package:virtual_mentor_app/core/widgets/text_fields/app_text_field.dart';
import 'package:virtual_mentor_app/features/auth/presentation/blocs/login_bloc.dart';
import 'package:virtual_mentor_app/features/auth/presentation/widgets/auth_background_shape_widget.dart';
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
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          // Save tokens then fire SessionLoggedIn
          await SecureStorageHelper.saveTokens(
            accessToken: state.auth.accessToken,
            refreshToken: state.auth.refreshToken,
          );
          if (context.mounted) {
            context.read<SessionBloc>().add(SessionLoggedIn());
            // GoRouter redirect handles navigation to home
          }
        } else if (state is LoginFailure) {
          AppSnackBar.error(context, state.message);
        }
      },

      child: Scaffold(
        backgroundColor: context.backgroundColor,
        body: SizedBox(
          width: AppSizes.designWidth.w,
          height: AppSizes.designHeight.h,
          child: Stack(
            children: [
              const AuthBackgroundShapeWidget(),
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
                          style: AppTextStyles.displayBold(
                            color: context.textPrimaryColor,
                          ),
                        ),
                        SizedBox(height: AppSizes.vsm),
                        Text(
                          context.tr.logToContinueJourney,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.labelRegular().copyWith(
                            color: context.textSecondaryColor,
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
                          validator: (value) => context.validateEmail(value),
                        ),
                        SizedBox(height: AppSizes.md),
                        AppTextField(
                          controller: _passwordController,
                          label: context.tr.password,
                          hint: context.tr.enterPassword,
                          isPassword: true,

                          textInputAction: TextInputAction.done,
                          validator: (value) => context.validatePassword(value),
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
                                  value: _rememberMe,
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
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              context.tr.remamber,
                              style: AppTextStyles.bodyM(
                                color: context.textSecondaryColor,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                context.go(AppRoutes.forgotPassword);
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
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return AppButton(
                              label: context.tr.login,
                              type: AppButtonType.primary,
                              isLoading: state is LoginLoading,
                              onTap: () {
                                // context.read<SessionBloc>().add(
                                //   SessionLoggedIn(),
                                // );
                                // return;
                                // if (_formKey.currentState?.validate() ??
                                //     false) {
                                context.read<LoginBloc>().add(
                                  LoginSubmitted(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text,
                                  ),
                                );
                                // }
                              },
                            );
                          },
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
                                context.go(AppRoutes.register);
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
                            style: AppTextStyles.bodyS(
                              color: context.textSecondaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: AppSizes.xxl),
                        // BlocBuilder<GoogleLoginCubit, GoogleLoginState>(
                        //   builder: (context, state) {
                        //     return LoginWithGoogleButton(
                        //       isLoading: state is GoogleLoginLoading,
                        //       onTap: () {
                        //         // TODO: Implement Google Sign-In
                        //         // Get idToken from Google Sign-In then:
                        //         // context.read<GoogleLoginCubit>().googleLogin(idToken);
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
