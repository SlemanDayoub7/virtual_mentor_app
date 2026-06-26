import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/router/app_router.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/features/auth/domain/entities/profile_entity.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_state.dart';
import '../widgets/home_course_card.dart';
import '../widgets/home_stats_row.dart';
import '../widgets/home_greeting_header.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  // Sample data — replace with real domain models/bloc state
  static const List<_CourseData> _courses = [
    _CourseData(
      svgAsset: 'assets/icons/ic_design.svg',
      title: 'تصميم واجهات المستخدم',
      subtitle: '6 مقارات · اخر نشاط منذ يومان',
      completedLessons: 8,
      totalLessons: 8,
      progressPercent: 1.0,
      statusLabel: 'مكتمل',
      isComplete: true,
    ),
    _CourseData(
      svgAsset: 'assets/icons/ic_analytics.svg',
      title: 'تحليل البيانات',
      subtitle: '8 مقارات · اخر نشاط اليوم',
      completedLessons: 6,
      totalLessons: 8,
      progressPercent: 0.75,
      statusLabel: '',
      isComplete: false,
    ),
    _CourseData(
      svgAsset: 'assets/icons/ic_security.svg',
      title: 'أمن المعلومات',
      subtitle: '12 مقارة · اختبار قادم',
      completedLessons: 5,
      totalLessons: 12,
      progressPercent: 0.42,
      statusLabel: '',
      isComplete: false,
    ),
    _CourseData(
      svgAsset: 'assets/icons/ic_mobile.svg',
      title: 'تطوير واجهات المستخدم',
      subtitle: '23 مقارة · اخر نشاط منذ يومان',
      completedLessons: 0,
      totalLessons: 23,
      progressPercent: 0.0,
      statusLabel: 'لم يتم البدأ',
      isComplete: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.screenBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.pagePadding,
                  vertical: AppSizes.vmd,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // ✅ BlocBuilder مع حالات التحميل والخطأ
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        return switch (state) {
                          // ✅ حالة التحميل
                          ProfileLoading() => _LoadingHeader(),

                          // ✅ حالة الخطأ
                          ProfileError(:final message) => _ErrorHeader(
                            message: message,
                            onRetry:
                                () =>
                                    context.read<ProfileCubit>().loadProfile(),
                          ),

                          // ✅ حالة نجاح تحميل البيانات
                          ProfileLoaded(:final profile) ||
                          ProfileUpdateSuccess(
                            :final profile,
                          ) => _ProfileHeader(
                            profile: profile,
                            onSelectSpecialty: () {
                              context.push(AppRoutes.categories);
                            },
                          ),

                          // ✅ أي حالة أخرى (افتراضية)
                          _ => const SizedBox.shrink(),
                        };
                      },
                    ),

                    // الإحصائيات
                    HomeStatsRow(
                      materialsCount: 4,
                      achievementPercent: 39,
                      testsCount: 9,
                    ),
                    SizedBox(height: AppSizes.vmd),
                    _SearchBar(),
                    SizedBox(height: AppSizes.vlg),
                    _SectionHeader(
                      title: 'موادي التعليمية',
                      actionLabel: 'عرض الكل',
                      onActionTap: () {},
                    ),
                    SizedBox(height: AppSizes.vsm),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, i) {
                final c = _courses[i];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.pagePadding,
                    vertical: AppSizes.vxs,
                  ),
                  child: HomeCourseCard(
                    svgAsset: c.svgAsset,
                    title: c.title,
                    subtitle: c.subtitle,
                    completedLessons: c.completedLessons,
                    totalLessons: c.totalLessons,
                    progressPercent: c.progressPercent,
                    statusLabel: c.statusLabel,
                    isComplete: c.isComplete,
                  ),
                );
              }, childCount: _courses.length),
            ),
            SliverToBoxAdapter(child: SizedBox(height: AppSizes.vlg)),
          ],
        ),
      ),
    );
  }

  // ✅ دالة للانتقال إلى صفحة تعديل الملف الشخصي
  void _navigateToEditProfile(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    final state = profileCubit.state;

    // استخراج البروفايل من الحالة الحالية
    ProfileEntity? profile;
    if (state is ProfileLoaded) {
      profile = state.profile;
    } else if (state is ProfileUpdateSuccess) {
      profile = state.profile;
    }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder:
    //         (_) => BlocProvider.value(
    //           value: profileCubit,
    //           child: EditProfileScreen(profile: profile),
    //         ),
    //   ),
    // );
  }
}

// ── واجهة رأس الصفحة عند تحميل البيانات ───────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.profile,
    required this.onSelectSpecialty,
  });

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
        // ✅ عرض تنبيه مع زر اختيار تخصص إذا لم يختر المستخدم تخصص
        if (!hasSpecialization)
          _NoSpecializationBanner(onSelectSpecialty: onSelectSpecialty),
        SizedBox(height: AppSizes.vxxxl),
      ],
    );
  }
}

// ── واجهة التحميل ───────────────────────────────────────────────────────────

class _LoadingHeader extends StatelessWidget {
  const _LoadingHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        HomeGreetingHeader(
          greeting: 'جاري التحميل...',
          name: '...',
          specialty: '...',
        ),
        SizedBox(
          height: 60.h,
          child: Center(
            child: SizedBox(
              width: 24.r,
              height: 24.r,
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                color: context.primaryColor,
              ),
            ),
          ),
        ),
        SizedBox(height: AppSizes.vxxxl),
      ],
    );
  }
}

// ── واجهة الخطأ ─────────────────────────────────────────────────────────────

class _ErrorHeader extends StatelessWidget {
  const _ErrorHeader({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        HomeGreetingHeader(
          greeting: 'مرحباً بك!',
          name: '...',
          specialty: '...',
        ),
        SizedBox(height: AppSizes.vsm),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.md,
            vertical: AppSizes.vmd,
          ),
          decoration: BoxDecoration(
            color: context.errorColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            border: Border.all(
              color: context.errorColor.withOpacity(0.3),
              width: 1.w,
            ),
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: context.errorColor,
                size: 24.r,
              ),
              SizedBox(width: AppSizes.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'تعذّر تحميل البيانات',
                      style: AppTextStyles.bodyBold(color: context.errorColor),
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      message,
                      style: AppTextStyles.captionRegular(
                        color: context.textSecondaryColor,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(height: AppSizes.vxs),
                    TextButton(
                      onPressed: onRetry,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'إعادة المحاولة',
                        style: AppTextStyles.bodyRegular(
                          color: context.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSizes.vxxxl),
      ],
    );
  }
}

// ── Banner لاختيار التخصص مع زر ────────────────────────────────────────────

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
          // صف الرمز والنص
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
          // ✅ زر اختيار التخصص
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

// ── Internal helpers (not exported) ────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: context.cardBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: context.borderColor),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(width: AppSizes.md),
          Icon(Icons.search, color: context.textHintColor, size: 20.r),
          SizedBox(width: AppSizes.sm),
          Text(
            'ابحث في المواد ...',
            style: AppTextStyles.bodyRegular(color: context.textHintColor),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onActionTap,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.titleMedium()),
        GestureDetector(
          onTap: onActionTap,
          child: Row(
            children: [
              Text(
                actionLabel,
                style: AppTextStyles.bodyRegular(color: context.primaryColor),
              ),
              Icon(
                Icons.chevron_right,
                size: 16.r,
                color: context.primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CourseData {
  const _CourseData({
    required this.svgAsset,
    required this.title,
    required this.subtitle,
    required this.completedLessons,
    required this.totalLessons,
    required this.progressPercent,
    required this.statusLabel,
    required this.isComplete,
  });

  final String svgAsset;
  final String title;
  final String subtitle;
  final int completedLessons;
  final int totalLessons;
  final double progressPercent;
  final String statusLabel;
  final bool isComplete;
}
