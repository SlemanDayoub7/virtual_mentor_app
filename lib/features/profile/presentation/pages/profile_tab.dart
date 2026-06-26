import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/router/app_router.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/core/utils/app_assets.dart';
import 'package:virtual_mentor_app/core/widgets/dialogs/app_snack_bar.dart';
import 'package:virtual_mentor_app/features/auth/domain/entities/profile_entity.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_state.dart';
import 'package:virtual_mentor_app/features/profile/presentation/pages/change_password_screen.dart';
import 'package:virtual_mentor_app/features/profile/presentation/pages/edit_profile_screen.dart';
import 'package:virtual_mentor_app/features/profile/presentation/widgets/delete_account_dialog.dart';
import 'package:virtual_mentor_app/features/profile/presentation/widgets/profile_settings_tile.dart';
import 'package:virtual_mentor_app/features/profile/presentation/widgets/profile_specialty_card.dart';
import 'package:virtual_mentor_app/features/profile/presentation/widgets/profile_stats_row.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listenWhen:
          (_, current) =>
              current is ProfileDeleteSuccess ||
              current is ProfileDeleteError ||
              current is ProfilePasswordChangeSuccess ||
              current is ProfilePasswordChangeError,
      listener: (context, state) {
        if (state is ProfileDeleteSuccess) {
          // Clear session and go to login
          // context.go(AppRoutes.login);
        }
        if (state is ProfileDeleteError) {
          _showSnack(context, state.message, isError: true);
        }
        if (state is ProfilePasswordChangeSuccess) {
          _showSnack(context, 'تم تغيير كلمة المرور بنجاح');
        }
        if (state is ProfilePasswordChangeError) {
          _showSnack(context, state.message, isError: true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.screenBackgroundColor,
          body: SafeArea(
            child: switch (state) {
              ProfileLoading() || ProfileUpdating() || ProfileDeleting() =>
                const Center(child: CircularProgressIndicator()),

              ProfileError(:final message) => _ErrorBody(
                message: message,
                onRetry: () => context.read<ProfileCubit>().loadProfile(),
              ),

              ProfileLoaded(:final profile) ||
              ProfileUpdateSuccess(
                :final profile,
              ) => _ProfileBody(profile: profile),

              _ => const Center(child: CircularProgressIndicator()),
            },
          ),
        );
      },
    );
  }

  void _showSnack(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    if (isError) {
      AppSnackBar.error(context, message);
    } else {
      AppSnackBar.success(context, message);
    }
  }
}

// ── Profile body (shown when data is available) ───────────────────────────────

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.profile});
  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    // التحقق من اكتمال الملف الشخصي
    final bool hasCompleteProfile =
        profile.profile?.hasCompleteProfile ?? false;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.pagePadding),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSizes.vmd),
            _ProfileAppBar(),
            SizedBox(height: AppSizes.vlg),
            _ProfileAvatar(avatarUrl: profile.profile?.avatar),
            SizedBox(height: AppSizes.vsm),
            Center(
              child: Column(
                children: [
                  Text(profile.fullName, style: AppTextStyles.titleBold()),
                  SizedBox(height: 4.h),
                  Text(
                    profile.email,
                    style: AppTextStyles.bodyRegular(
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSizes.vmd),

            // ✅ عرض زر إكمال الملف الشخصي إذا كانت البيانات ناقصة
            if (!hasCompleteProfile) _CompleteProfileBanner(),

            const ProfileStatsRow(
              materialsCount: 4,
              achievementPercent: 39,
              testsCount: 9,
            ),
            SizedBox(height: AppSizes.vmd),
            ProfileSpecialtyCard(
              specialty: profile.profile?.currentCategory?.name ?? '—',
              onEdit: () {
                context.push(AppRoutes.categories);
              },
            ),
            SizedBox(height: AppSizes.vlg),
            Text('إعدادات الحساب', style: AppTextStyles.titleMedium()),
            SizedBox(height: AppSizes.vsm),
            _SettingsSection(profile: profile),
            SizedBox(height: AppSizes.vlg),
          ],
        ),
      ),
    );
  }
}

// ── Banner لإكمال الملف الشخصي ────────────────────────────────────────────

class _CompleteProfileBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.vmd,
      ),
      margin: EdgeInsets.only(bottom: AppSizes.vmd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.primaryColor, context.primaryColor.withOpacity(0.7)],
          begin: Alignment.topRight,
          end: Alignment.topLeft,
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: context.whiteColor,
                size: 28.r,
              ),
              Text(
                'ملفك الشخصي غير مكتمل',
                style: AppTextStyles.titleBold(color: context.whiteColor),
              ),
            ],
          ),
          SizedBox(height: AppSizes.vxs),
          Text(
            'يرجى إكمال بياناتك الشخصية للاستفادة من جميع الخدمات',
            style: AppTextStyles.bodyRegular(
              color: context.whiteColor.withOpacity(0.9),
            ),
            textAlign: TextAlign.end,
          ),
          SizedBox(height: AppSizes.vsm),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // الانتقال إلى شاشة تعديل الملف الشخصي
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder:
                //         (_) => BlocProvider.value(
                //           value: context.read<ProfileCubit>(),
                //           child: EditProfileScreen(
                //             profile: context.read<ProfileCubit>().state is ProfileLoaded
                //                 ? (context.read<ProfileCubit>().state as ProfileLoaded).profile
                //                 : null,
                //           ),
                //         ),
                //   ),
                // );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.whiteColor,
                foregroundColor: context.primaryColor,
                padding: EdgeInsets.symmetric(vertical: AppSizes.vmd),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
              ),
              child: Text('أكمل ملفك الشخصي الآن'),
            ),
          ),
        ],
      ),
    );
  }
}

// ── App bar ───────────────────────────────────────────────────────────────────

class _ProfileAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('الملف الشخصي', style: AppTextStyles.titleMedium()),
        Icon(
          Icons.settings_outlined,
          size: AppSizes.iconMd,
          color: context.textPrimaryColor,
        ),
      ],
    );
  }
}

// ── Avatar ────────────────────────────────────────────────────────────────────

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({this.avatarUrl});
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            width: 88.r,
            height: 88.r,
            decoration: BoxDecoration(
              color: context.surfaceVariantColor,
              shape: BoxShape.circle,
              border: Border.all(color: context.borderColor, width: 2.w),
            ),
            child: ClipOval(
              child:
                  avatarUrl != null
                      ? Image.network(avatarUrl!, fit: BoxFit.cover)
                      : Icon(
                        Icons.person_rounded,
                        size: 52.r,
                        color: context.textSecondaryColor,
                      ),
            ),
          ),
          Container(
            width: 26.r,
            height: 26.r,
            decoration: BoxDecoration(
              color: context.primaryColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: context.cardBackgroundColor,
                width: 2.w,
              ),
            ),
            child: Icon(
              Icons.camera_alt_outlined,
              size: 14.r,
              color: context.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Settings section ──────────────────────────────────────────────────────────

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.profile});
  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.cardBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        children: [
          ProfileSettingsTile(
            svgAsset: AppAssets.editProfile,
            label: 'تعديل الملف الشخصي',
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => BlocProvider.value(
                          value: context.read<ProfileCubit>(),
                          child: EditProfileScreen(profile: profile),
                        ),
                  ),
                ),
          ),
          Divider(height: 1, color: context.dividerColor),
          ProfileSettingsTile(
            svgAsset: AppAssets.lock,
            label: 'تغيير كلمة المرور',
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => BlocProvider.value(
                          value: context.read<ProfileCubit>(),
                          child: const ChangePasswordScreen(),
                        ),
                  ),
                ),
          ),
          Divider(height: 1, color: context.dividerColor),
          ProfileSettingsTile(
            svgAsset: AppAssets.delete,
            label: 'حذف الحساب',
            labelColor: context.errorColor,
            isDestructive: true,
            onTap:
                () => showDialog(
                  context: context,
                  builder:
                      (_) => BlocProvider.value(
                        value: context.read<ProfileCubit>(),
                        child: const DeleteAccountDialog(),
                      ),
                ),
          ),
        ],
      ),
    );
  }
}

// ── Error body ────────────────────────────────────────────────────────────────

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.wifi_off_rounded, size: 48, color: AppColors.grey400),
          SizedBox(height: 16.h),
          Text(
            'تعذّر تحميل الملف',
            style: AppTextStyles.titleMedium(),
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: AppTextStyles.captionRegular(),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
            ),
            child: Text('إعادة المحاولة', style: AppTextStyles.button()),
          ),
        ],
      ),
    );
  }
}
