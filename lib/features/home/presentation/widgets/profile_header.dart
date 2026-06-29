import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/features/auth/domain/entities/profile_entity.dart';
import 'package:virtual_mentor_app/features/home/presentation/widgets/home_greeting_header.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.profile, required this.onSelectSpecialty});

  final ProfileEntity profile;
  final VoidCallback onSelectSpecialty;

  @override
  Widget build(BuildContext context) {
    final specialty = profile.profile?.currentCategory?.name ?? '—';
    final hasSpecialization = profile.hasSpecialization;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        HomeGreetingHeader(
          greeting: 'صباح الخير أيها الطالب الساعي !',
          name: profile.fullName,
          specialty: specialty,
        ),
        if (!hasSpecialization)
          _NoSpecializationBanner(onSelectSpecialty: onSelectSpecialty),
        SizedBox(height: AppSizes.vxxxl),
      ],
    );
  }
}

// ── No Specialization Banner ───────────────────────────────────────────────

class _NoSpecializationBanner extends StatelessWidget {
  const _NoSpecializationBanner({required this.onSelectSpecialty});

  final VoidCallback onSelectSpecialty;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.vmd,
      ),
      margin: EdgeInsets.only(top: AppSizes.vsm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.errorColor.withOpacity(0.15),
            context.errorColor.withOpacity(0.05),
          ],
          begin: Alignment.topRight,
          end: Alignment.topLeft,
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(
          color: context.errorColor.withOpacity(0.3),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.school_outlined,
                color: context.errorColor,
                size: 28.r,
              ),
              Expanded(
                child: Text(
                  'لم تختر تخصصك بعد!',
                  style: AppTextStyles.titleBold(color: context.errorColor),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.vxs),
          Text(
            'اختر تخصصك المناسب وابدأ رحلة التعلم المثالية لك',
            style: AppTextStyles.bodyRegular(color: context.textSecondaryColor),
            textAlign: TextAlign.end,
          ),
          SizedBox(height: AppSizes.vmd),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onSelectSpecialty,
              icon: Icon(
                Icons.arrow_forward_rounded,
                size: 20.r,
                color: context.whiteColor,
              ),
              label: Text(
                'اختيار التخصص',
                style: AppTextStyles.button(color: context.whiteColor),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.primaryColor,
                foregroundColor: context.whiteColor,
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.md,
                  vertical: AppSizes.vmd,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
