import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/core/widgets/text_fields/app_text_field.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_state.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key});

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // Success is handled in ProfileTab (which will pop to login)
        if (state is ProfileDeleteError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message, textDirection: TextDirection.rtl),
              backgroundColor: AppColors.error,
            ),
          );
          Navigator.pop(context); // close dialog
        }
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'حذف الحساب',
          style: AppTextStyles.titleBold(color: AppColors.error),
          textDirection: TextDirection.rtl,
        ),
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'هذا الإجراء لا يمكن التراجع عنه. أدخل كلمة المرور للتأكيد.',
                style: AppTextStyles.bodyRegular(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 16.h),
              AppTextField(
                controller: _passwordCtrl,
                label: 'كلمة المرور',
                hint: '••••••••',
                isPassword: true,
                suffixIcon: Icons.lock_outline,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: AppTextStyles.bodyRegular(color: AppColors.textSecondary),
            ),
          ),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              final loading = state is ProfileDeleting;
              return TextButton(
                onPressed:
                    loading
                        ? null
                        : () => context.read<ProfileCubit>().deleteAccount(
                          currentPassword: _passwordCtrl.text.trim(),
                        ),
                child:
                    loading
                        ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : Text(
                          'حذف',
                          style: AppTextStyles.bodyRegular(
                            color: AppColors.error,
                          ),
                        ),
              );
            },
          ),
        ],
      ),
    );
  }
}
