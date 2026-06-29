import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_mentor_app/core/di/injection_container.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/router/app_router.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/core/widgets/image/app_image.dart';
import 'package:virtual_mentor_app/features/auth/domain/entities/profile_entity.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/category_progress_entity.dart';
import 'package:virtual_mentor_app/features/course/presentation/blocs/category_progress/category_progress_bloc.dart';
import 'package:virtual_mentor_app/features/course/presentation/blocs/subject_detail/subject_detail_bloc.dart';
import 'package:virtual_mentor_app/features/course/presentation/screens/subject_detail_screen.dart';
import 'package:virtual_mentor_app/features/home/presentation/widgets/error_header.dart';
import 'package:virtual_mentor_app/features/home/presentation/widgets/home_search_bar.dart';
import 'package:virtual_mentor_app/features/home/presentation/widgets/home_stats_row.dart';
import 'package:virtual_mentor_app/features/home/presentation/widgets/profile_header.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_state.dart';
import '../widgets/home_greeting_header.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return switch (state) {
                        ProfileLoading() => _LoadingHeader(),
                        ProfileError(:final message) => ErrorHeader(
                          message: message,
                          onRetry:
                              () => context.read<ProfileCubit>().loadProfile(),
                        ),
                        ProfileLoaded(:final profile) ||
                        ProfileUpdateSuccess(:final profile) => ProfileHeader(
                          profile: profile,
                          onSelectSpecialty: () {
                            context.push(AppRoutes.categories);
                          },
                        ),
                        _ => const SizedBox.shrink(),
                      };
                    },
                  ),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoaded ||
                          state is ProfileUpdateSuccess) {
                        final profile =
                            state is ProfileLoaded
                                ? state.profile
                                : (state as ProfileUpdateSuccess).profile;

                        final categoryId = profile.profile?.currentCategory?.id;

                        // If no category selected, show empty state
                        if (categoryId == null) {
                          return EmptyCategoryProgress();
                        }

                        // Load category progress
                        return BlocBuilder<
                          CategoryProgressBloc,
                          CategoryProgressState
                        >(
                          builder: (context, progressState) {
                            // Trigger loading if not loaded yet
                            if (progressState is CategoryProgressInitial) {
                              context.read<CategoryProgressBloc>().add(
                                GetCategoryProgress(categoryId),
                              );
                              return const CategoryProgressLoading();
                            }

                            if (progressState is CategoryProgressLoading) {
                              return const CategoryProgressLoading();
                            }

                            if (progressState is CategoryProgressLoaded) {
                              return HomeStatsRow(
                                materialsCount:
                                    progressState
                                        .progress
                                        .specialization
                                        .totalSubjects,
                                achievementPercent:
                                    progressState
                                        .progress
                                        .summary
                                        .overallProgress,
                                xp: progressState.progress.summary.totalXp,
                              );
                            }

                            if (progressState is CategoryProgressFailure) {
                              return CategoryProgressError(
                                message: progressState.message,
                                onRetry: () {
                                  context.read<CategoryProgressBloc>().add(
                                    GetCategoryProgress(categoryId),
                                  );
                                },
                              );
                            }

                            return const SizedBox.shrink();
                          },
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                  // // ✅ Stats Row with real data
                  // BlocBuilder<ProfileCubit, ProfileState>(
                  //   builder: (context, state) {
                  //     if (state is ProfileLoaded ||
                  //         state is ProfileUpdateSuccess) {
                  //       final profile =
                  //           state is ProfileLoaded
                  //               ? state.profile
                  //               : (state as ProfileUpdateSuccess).profile;

                  //       // Get stats from profile or use defaults
                  //       final totalSubjects =
                  //           profile.profile?.currentCategory.
                  //           0;
                  //       final progress = profile.profile?.progress ?? 0;

                  //       return HomeStatsRow(
                  //         materialsCount: totalSubjects,
                  //         achievementPercent: progress.toInt(),
                  //         testsCount:
                  //             0, // You can add tests count if available
                  //       );
                  //     }
                  //     return HomeStatsRow(
                  //       materialsCount: 0,
                  //       achievementPercent: 0,
                  //       testsCount: 0,
                  //     );
                  //   },
                  // ),
                  SizedBox(height: AppSizes.vmd),
                  HomeSearchBar(),
                  SizedBox(height: AppSizes.vlg),

                  // ✅ Category Progress Section
                  _buildCategoryProgressSection(context),

                  SizedBox(height: AppSizes.vsm),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Build Category Progress Section
  Widget _buildCategoryProgressSection(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded || state is ProfileUpdateSuccess) {
          final profile =
              state is ProfileLoaded
                  ? state.profile
                  : (state as ProfileUpdateSuccess).profile;

          final categoryId = profile.profile?.currentCategory?.id;

          // If no category selected, show empty state
          if (categoryId == null) {
            return EmptyCategoryProgress();
          }

          // Load category progress
          return BlocBuilder<CategoryProgressBloc, CategoryProgressState>(
            builder: (context, progressState) {
              // Trigger loading if not loaded yet
              if (progressState is CategoryProgressInitial) {
                context.read<CategoryProgressBloc>().add(
                  GetCategoryProgress(categoryId),
                );
                return const CategoryProgressLoading();
              }

              if (progressState is CategoryProgressLoading) {
                return const CategoryProgressLoading();
              }

              if (progressState is CategoryProgressLoaded) {
                return _CategoryProgressContent(
                  progress: progressState.progress,
                  onSeeAll: () {},
                );
              }

              if (progressState is CategoryProgressFailure) {
                return CategoryProgressError(
                  message: progressState.message,
                  onRetry: () {
                    context.read<CategoryProgressBloc>().add(
                      GetCategoryProgress(categoryId),
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

// ── Category Progress Content ──────────────────────────────────────────────

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

class _CategoryProgressContent extends StatelessWidget {
  const _CategoryProgressContent({
    required this.progress,
    required this.onSeeAll,
  });

  final CategoryProgressEntity progress;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('موادي التعليمية', style: AppTextStyles.titleMedium()),
        SizedBox(height: AppSizes.vsm),

        ...progress.subjects.map(
          (subject) => SubjectProgressCard(
            subject: subject,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider(
                        create:
                            (context) =>
                                sl<SubjectDetailBloc>()
                                  ..add(LoadSubjectDetail(subject)),
                        child: SubjectDetailScreen(
                          subject: subject,
                          categoryId: progress.specialization.id,
                        ),
                      ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProgressStat extends StatelessWidget {
  const ProgressStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              value,
              style: AppTextStyles.titleMedium(color: context.whiteColor),
            ),
            SizedBox(width: AppSizes.xs),
            Icon(icon, color: context.whiteColor.withOpacity(0.8), size: 16.r),
          ],
        ),
        Text(
          label,
          style: AppTextStyles.captionRegular(
            color: context.whiteColor.withOpacity(0.7),
          ),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}

// ── Subject Progress Card ─────────────────────────────────────────────────

class SubjectProgressCard extends StatelessWidget {
  const SubjectProgressCard({required this.subject, required this.onTap});

  final SubjectProgressEntity subject;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: AppSizes.vxs),
        padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 25.5.r),
        decoration: BoxDecoration(
          color: context.whiteColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
          border: Border.all(color: context.borderColor, width: 1.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10.r,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: context.skyBlueColor,
                    borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                  ),
                  padding: EdgeInsets.all(19.r),
                  child: Icon(Icons.category),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subject.name, style: AppTextStyles.bodyBold()),
                      SizedBox(height: AppSizes.vxs),
                      Text(
                        '${subject.stats.totalSkills} مهارات${subject.recentActivity == null ? '' : ' | اخر نشاط منذ ' + _getTimeAgo(DateTime.tryParse(subject.recentActivity!.lastAssessmentDate.toString()))}',
                        style: AppTextStyles.captionRegular(
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSizes.vxs),
          ],
        ),
      ),
    );
  }
}

String _getTimeAgo(DateTime? date) {
  if (date == null) return '';

  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inDays >= 30) {
    final months = (difference.inDays / 30).floor();
    return '$months شهر${months > 1 ? 'ان' : ''}';
  } else if (difference.inDays >= 7) {
    final weeks = (difference.inDays / 7).floor();
    return '$weeks اسبوع${weeks > 1 ? 'ان' : ''}';
  } else if (difference.inDays >= 2) {
    return '${difference.inDays} ايام';
  } else if (difference.inDays == 1) {
    return 'يوم';
  } else if (difference.inHours >= 2) {
    return '${difference.inHours} ساعات';
  } else if (difference.inHours >= 1) {
    return 'ساعة';
  } else if (difference.inMinutes >= 2) {
    return '${difference.inMinutes} دقائق';
  } else {
    return 'الان';
  }
}
// ── Loading State ──────────────────────────────────────────────────────────

class CategoryProgressLoading extends StatelessWidget {
  const CategoryProgressLoading();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSizes.vlg),
      child: Center(
        child: Column(
          children: [
            CircularProgressIndicator(
              strokeWidth: 2.w,
              color: context.primaryColor,
            ),
            SizedBox(height: AppSizes.vsm),
            Text(
              'جاري تحميل التقدم...',
              style: AppTextStyles.bodyRegular(
                color: context.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Error State ────────────────────────────────────────────────────────────

class CategoryProgressError extends StatelessWidget {
  const CategoryProgressError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSizes.vlg),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: context.errorColor,
              size: 40.r,
            ),
            SizedBox(height: AppSizes.vsm),
            Text(
              'تعذر تحميل التقدم',
              style: AppTextStyles.bodyBold(color: context.errorColor),
            ),
            SizedBox(height: AppSizes.vxs),
            Text(
              message,
              style: AppTextStyles.captionRegular(
                color: context.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSizes.vmd),
            TextButton(
              onPressed: onRetry,
              child: Text(
                'إعادة المحاولة',
                style: AppTextStyles.bodyRegular(color: context.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Empty Category Progress ───────────────────────────────────────────────

class EmptyCategoryProgress extends StatelessWidget {
  const EmptyCategoryProgress();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSizes.vlg),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.school_outlined,
              color: context.textHintColor,
              size: 48.r,
            ),
            SizedBox(height: AppSizes.vsm),
            Text(
              'لم تختر تخصصاً بعد',
              style: AppTextStyles.bodyBold(color: context.textSecondaryColor),
            ),
            SizedBox(height: AppSizes.vxs),
            Text(
              'اختر تخصصك لترى تقدمك هنا',
              style: AppTextStyles.captionRegular(color: context.textHintColor),
            ),
            SizedBox(height: AppSizes.vmd),
            ElevatedButton(
              onPressed: () {
                context.push(AppRoutes.categories);
              },
              child: Text('اختيار التخصص'),
            ),
          ],
        ),
      ),
    );
  }
}
