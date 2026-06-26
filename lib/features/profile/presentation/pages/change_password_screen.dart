import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/core/widgets/buttons/app_button.dart';
import 'package:virtual_mentor_app/core/widgets/text_fields/app_text_field.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_newCtrl.text != _confirmCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'كلمتا المرور غير متطابقتين',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    context.read<ProfileCubit>().changePassword(
      currentPassword: _currentCtrl.text.trim(),
      newPassword: _newCtrl.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfilePasswordChangeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'تم تغيير كلمة المرور',
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: AppColors.success,
            ),
          );
          Navigator.pop(context);
        }
        if (state is ProfilePasswordChangeError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message, textDirection: TextDirection.rtl),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: context.screenBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.pagePadding,
              vertical: AppSizes.vmd,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: AppSizes.iconMd,
                          color: context.textPrimaryColor,
                        ),
                      ),
                      SizedBox(width: AppSizes.sm),
                      Text(
                        'تغيير كلمة المرور',
                        style: AppTextStyles.titleBold(),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.vlg),
                  AppTextField(
                    controller: _currentCtrl,
                    label: 'كلمة المرور الحالية',
                    hint: '••••••••',
                    isPassword: true,
                    suffixIcon: Icons.lock_outline,
                  ),
                  SizedBox(height: AppSizes.vmd),
                  AppTextField(
                    controller: _newCtrl,
                    label: 'كلمة المرور الجديدة',
                    hint: '••••••••',
                    isPassword: true,
                    suffixIcon: Icons.lock_outline,
                  ),
                  SizedBox(height: AppSizes.vmd),
                  AppTextField(
                    controller: _confirmCtrl,
                    label: 'تأكيد كلمة المرور',
                    hint: '••••••••',
                    isPassword: true,
                    suffixIcon: Icons.lock_outline,
                  ),
                  SizedBox(height: AppSizes.vlg),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      final loading = state is ProfilePasswordChanging;
                      return AppButton(
                        label: loading ? '...' : 'حفظ',
                        onTap: loading ? null : _submit,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
