// lib/features/course/presentation/screens/subject_detail_screen.dart
//
// ── ملاحظة التصميم ───────────────────────────────────────────────────────
// الشكل العام مستوحى من Frame_1171276046:
//  - كارد واحد بزوايا دائرية (radiusLg) يحتوي قسمين داخل نفس الـ Clip:
//      1) قسم علوي "زجاجي" فاتح: حلقة Progress متدرجة (successColor →
//         primaryLightColor → primaryColor) + Badge مربّع للإنجاز
//         (خلفية cardBackgroundColor + حد primaryColor شفاف).
//      2) قسم سفلي بخلفية primaryColor صلبة ونص أبيض: صف إحصائيات (أيقونة/رقم/تسمية).
//  - كل الألوان من AppColors/context (لا ألوان hex خارجية)، وكل المقاسات من
//    AppSizes أو وحدات flutter_screenutil (.w/.h/.r) المستخدمة في باقي الملف.
//    مستويات المهارات (مبتدئ/متوسط/متقدم) تستخدم نفس عائلة الألوان أعلاه
//    بدل Colors.blue/orange/green العشوائية.
// ────────────────────────────────────────────────────────────────────────

import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/category_progress_entity.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/skill_profile_entity.dart';
import 'package:virtual_mentor_app/features/course/presentation/blocs/subject_detail/subject_detail_bloc.dart';

// ── شريحة الألوان (مأخوذة بالكامل من AppColors / extensions الخاصة بك) ──
class _GradientPalette {
  // تدرّج حلقة التقدّم: من success → primaryLight → primary (ألوانك فقط)
  static List<Color> ring(BuildContext context) => [
    context.successColor,
    context.primaryLightColor,
    context.primaryColor,
  ];

  // مستوى المهارة → لون من نفس عائلتك (لا ألوان خارجية)
  static Color forLevel(BuildContext context, String? level) {
    switch (level) {
      case 'beginner':
        return context.primaryLightColor;
      case 'intermediate':
        return context.primaryColor;
      case 'advanced':
        return context.successColor;
      default:
        return context.textHintColor;
    }
  }
}

class SubjectDetailScreen extends StatefulWidget {
  final SubjectProgressEntity subject;
  final int categoryId;

  const SubjectDetailScreen({
    super.key,
    required this.subject,
    required this.categoryId,
  });

  @override
  State<SubjectDetailScreen> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SubjectDetailBloc>().add(LoadSubjectDetail(widget.subject));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.screenBackgroundColor,
      appBar: AppBar(
        title: Text(widget.subject.name, style: AppTextStyles.titleBold()),
        backgroundColor: context.screenBackgroundColor,
        elevation: 0,
      ),
      body: BlocBuilder<SubjectDetailBloc, SubjectDetailState>(
        builder: (context, state) {
          if (state is SubjectDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SubjectDetailLoaded) {
            return _SubjectDetailContent(
              subject: state.subject,
              skillProfiles: state.skillProfiles,
              isLoadingProfiles: state.isLoadingProfiles,
              error: state.error,
              onRetry: () {
                context.read<SubjectDetailBloc>().add(
                  LoadSubjectDetail(state.subject),
                );
              },
            );
          } else if (state is SubjectDetailFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: AppTextStyles.bodyRegular(color: context.errorColor),
                  ),
                  SizedBox(height: AppSizes.vmd),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SubjectDetailBloc>().add(
                        LoadSubjectDetail(widget.subject),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// ── Subject Detail Content ─────────────────────────────────────────────────

class _SubjectDetailContent extends StatelessWidget {
  const _SubjectDetailContent({
    required this.subject,
    required this.skillProfiles,
    required this.isLoadingProfiles,
    required this.error,
    required this.onRetry,
  });

  final SubjectProgressEntity subject;
  final List<SkillProfileEntity> skillProfiles;
  final bool isLoadingProfiles;
  final String? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSizes.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // البطاقة الرئيسية: زجاجية بالأعلى + بانر إحصائيات أزرق بالأسفل
          _SubjectHeroCard(subject: subject),
          SizedBox(height: AppSizes.vlg),

          // Quick Stats (if available)
          if (subject.quickStats != null)
            _QuickStatsCard(quickStats: subject.quickStats!),
          if (subject.quickStats != null) SizedBox(height: AppSizes.vlg),

          // Recent Activity (if available)
          if (subject.recentActivity != null)
            _RecentActivityCard(recentActivity: subject.recentActivity!),
          if (subject.recentActivity != null) SizedBox(height: AppSizes.vlg),

          // Skills Section
          _SkillsSection(
            skillProfiles: skillProfiles,
            isLoading: isLoadingProfiles,
            error: error,
            onRetry: onRetry,
          ),
        ],
      ),
    );
  }
}

// ── Subject Hero Card (يطابق pattern الصورة) ───────────────────────────────
//
// قسم علوي زجاجي شفاف فيه: Badge إنجاز + حلقة تقدّم متدرجة + اسم/وصف المادة.
// قسم سفلي بخلفية primary صلبة ونص أبيض فيه صف إحصائيات (مهارات/خبرة/متوسط/متقن).
// كلا القسمين داخل ClipRRect واحد لضمان أن الزوايا الخارجية فقط مستديرة،
// تماماً كما في الصورة الأصلية (كارد واحد بلونين).

class _SubjectHeroCard extends StatelessWidget {
  const _SubjectHeroCard({required this.subject});

  final SubjectProgressEntity subject;

  @override
  Widget build(BuildContext context) {
    final stats = subject.stats;
    final statusColor =
        subject.status == 'completed'
            ? context.successColor
            : subject.status == 'in_progress'
            ? context.errorColor
            : context.textHintColor;

    final statusText =
        subject.status == 'completed'
            ? '✅ مكتمل'
            : subject.status == 'in_progress'
            ? '🔄 قيد التقدم'
            : '⏳ لم يبدأ';

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.white.withOpacity(0.4),
            width: 1.w,
          ),
        ),
        child: Column(
          children: [
            // ── القسم الزجاجي العلوي ─────────────────────────────────
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppSizes.lg),
                color: context.cardBackgroundColor.withOpacity(
                  context.isDark ? 1.0 : 0.85,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Badge الإنجاز (يقابل المربع 64x64 في الصورة)
                        _AchievementBadge(
                          icon:
                              stats.masteredSkills > 0
                                  ? Icons.emoji_events_rounded
                                  : Icons.school_rounded,
                        ),
                        // حلقة التقدم المتدرجة (تقابل الدائرة في الصورة)
                        _ProgressRing(percentage: stats.progressPercentage),
                      ],
                    ),
                    SizedBox(height: AppSizes.vmd),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(subject.name, style: AppTextStyles.titleBold()),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.sm,
                            vertical: AppSizes.vxs,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusXs,
                            ),
                            border: Border.all(
                              color: statusColor.withOpacity(0.3),
                              width: 0.5.w,
                            ),
                          ),
                          child: Text(
                            statusText,
                            style: AppTextStyles.captionRegular(
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.vxs),
                    Text(
                      subject.description,
                      style: AppTextStyles.bodyRegular(
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.vlg,
                horizontal: AppSizes.sm,
              ),
              color: context.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _BannerStat(
                    icon: Icons.emoji_events_rounded,
                    value: '${stats.totalSkills}',
                    label: 'المهارات',
                  ),
                  _BannerStat(
                    icon: Icons.lightbulb_rounded,
                    value: '${stats.totalConcepts}',
                    label: 'المفاهيم',
                  ),
                  _BannerStat(
                    icon: Icons.stars_rounded,
                    value: '${stats.totalXp}',
                    label: 'نقاط الخبرة',
                  ),
                  _BannerStat(
                    icon: Icons.check_circle_rounded,
                    value: '${stats.masteredSkills}',
                    label: 'متقن',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Badge مربّع للإنجاز — يقابل المستطيل 64x64 (خلفية cardBackground + حد primary شفاف)
class _AchievementBadge extends StatelessWidget {
  const _AchievementBadge({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.avatarLg,
      height: AppSizes.avatarLg,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.cardBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(
          color: context.primaryColor.withOpacity(0.2),
          width: 1.w,
        ),
      ),
      child: Icon(icon, color: context.primaryColor, size: AppSizes.iconLg),
    );
  }
}

// حلقة التقدم المتدرجة — تقابل الدائرة ذات الحد المتدرج في الصورة، بألوانك
class _ProgressRing extends StatelessWidget {
  const _ProgressRing({required this.percentage});

  final double percentage;

  @override
  Widget build(BuildContext context) {
    final size = AppSizes.avatarLg + AppSizes.sm; // أكبر قليلاً من البادج
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingPainter(
          percentage: percentage.clamp(0, 100),
          trackColor: context.borderColor,
          ringColors: _GradientPalette.ring(context),
          strokeWidth: AppSizes.xs,
        ),
        child: Center(
          child: Text(
            '${percentage.toStringAsFixed(0)}%',
            style: AppTextStyles.bodyBold(color: context.successColor),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.percentage,
    required this.trackColor,
    required this.ringColors,
    required this.strokeWidth,
  });

  final double percentage;
  final Color trackColor;
  final List<Color> ringColors;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final trackPaint =
        Paint()
          ..color = trackColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, trackPaint);

    final sweep = 2 * math.pi * (percentage / 100);
    if (sweep <= 0) return;

    final progressPaint =
        Paint()
          ..shader = SweepGradient(
            colors: ringColors,
            startAngle: 0,
            endAngle: sweep,
            transform: GradientRotation(-math.pi / 2),
          ).createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -math.pi / 2, sweep, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.percentage != percentage ||
      oldDelegate.trackColor != trackColor ||
      oldDelegate.strokeWidth != strokeWidth;
}

// عنصر إحصائية مفردة داخل البانر الأزرق (أيقونة أبيض + رقم + تسمية)
class _BannerStat extends StatelessWidget {
  const _BannerStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.white, size: AppSizes.iconMd),
        SizedBox(height: AppSizes.vxs),
        Text(value, style: AppTextStyles.bodyBold(color: AppColors.white)),
        SizedBox(height: AppSizes.vxs / 2),
        Text(
          label,
          style: AppTextStyles.captionRegular(
            color: AppColors.white.withOpacity(0.85),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ── Quick Stats Card ──────────────────────────────────────────────────────

class _QuickStatsCard extends StatelessWidget {
  const _QuickStatsCard({required this.quickStats});

  final QuickStatsEntity quickStats;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: context.cardBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: context.borderColor, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('📊 إحصائيات سريعة', style: AppTextStyles.titleMedium()),
          SizedBox(height: AppSizes.vsm),

          Row(
            children: [
              Expanded(
                child: _SkillLevelCard(
                  label: '💪 الأقوى',
                  skill: quickStats.strongestSkill,
                  color: context.successColor,
                ),
              ),
              SizedBox(width: AppSizes.sm),
              Expanded(
                child: _SkillLevelCard(
                  label: '⚠️ الأضعف',
                  skill: quickStats.weakestSkill,
                  color: context.errorColor,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.vsm),
          // Skills by Level
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _LevelBadge(
                label: 'مبتدئ',
                count: quickStats.skillsByLevel.beginner,
                color: _GradientPalette.forLevel(context, 'beginner'),
              ),
              _LevelBadge(
                label: 'متوسط',
                count: quickStats.skillsByLevel.intermediate,
                color: _GradientPalette.forLevel(context, 'intermediate'),
              ),
              _LevelBadge(
                label: 'متقدم',
                count: quickStats.skillsByLevel.advanced,
                color: _GradientPalette.forLevel(context, 'advanced'),
              ),
            ],
          ),
          if (quickStats.nextAssessmentAvailable > 0)
            Padding(
              padding: EdgeInsets.only(top: AppSizes.vsm),
              child: Container(
                padding: EdgeInsets.all(AppSizes.sm),
                decoration: BoxDecoration(
                  color: context.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusXs),
                ),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: context.primaryColor,
                      size: 16.r,
                    ),
                    SizedBox(width: AppSizes.xs),
                    Text(
                      'تقييم جديد متاح خلال ${quickStats.nextAssessmentAvailable} يوم',
                      style: AppTextStyles.captionRegular(
                        color: context.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SkillLevelCard extends StatelessWidget {
  const _SkillLevelCard({
    required this.label,
    required this.skill,
    required this.color,
  });

  final String label;
  final SkillSummaryEntity? skill;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (skill == null) {
      return Container(
        padding: EdgeInsets.all(AppSizes.sm),
        decoration: BoxDecoration(
          color: context.borderColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: AppTextStyles.captionRegular(
                color: context.textSecondaryColor,
              ),
            ),
            SizedBox(height: AppSizes.vxs),
            Text(
              '—',
              style: AppTextStyles.bodyRegular(color: context.textHintColor),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(AppSizes.sm),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        border: Border.all(color: color.withOpacity(0.3), width: 0.5.w),
      ),
      child: Column(
        spacing: 5.r,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTextStyles.captionRegular(
              color: context.textSecondaryColor,
            ),
          ),
          Text(
            skill!.name,
            style: AppTextStyles.bodyBold(color: color),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.xs,
              vertical: AppSizes.vxs / 2,
            ),
            decoration: BoxDecoration(
              color: _GradientPalette.forLevel(
                context,
                skill!.level,
              ).withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppSizes.radiusXs),
            ),
            child: Text(
              skill!.score.toStringAsFixed(0),
              style: AppTextStyles.captionRegular(
                color: _GradientPalette.forLevel(context, skill!.level),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  const _LevelBadge({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.sm,
        vertical: AppSizes.vxs,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusXs),
        border: Border.all(color: color.withOpacity(0.3), width: 0.5.w),
      ),
      child: Column(
        children: [
          Text('$count', style: AppTextStyles.bodyBold(color: color)),
          Text(
            label,
            style: AppTextStyles.captionRegular(
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Recent Activity Card ──────────────────────────────────────────────────

class _RecentActivityCard extends StatelessWidget {
  const _RecentActivityCard({required this.recentActivity});

  final RecentActivityEntity recentActivity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: context.cardBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: context.borderColor, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('🕐 آخر نشاط', style: AppTextStyles.titleMedium()),
          SizedBox(height: AppSizes.vsm),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ActivityItem(
                label: 'آخر مهارة تم تقييمها',
                value: recentActivity.lastSkillAssessed,
                icon: Icons.school_rounded,
              ),
              if (recentActivity.lastAssessmentDate != null)
                _ActivityItem(
                  label: 'تاريخ التقييم',
                  value: _formatDate(recentActivity.lastAssessmentDate!),
                  icon: Icons.calendar_today_rounded,
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return 'منذ ${difference.inDays} يوم';
      } else if (difference.inHours > 0) {
        return 'منذ ${difference.inHours} ساعة';
      } else if (difference.inMinutes > 0) {
        return 'منذ ${difference.inMinutes} دقيقة';
      } else {
        return 'الآن';
      }
    } catch (e) {
      return dateString;
    }
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({
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
      spacing: 5.r,
      children: [
        Icon(icon, color: context.primaryColor, size: 20.r),
        SizedBox(height: AppSizes.vxs),
        Text(
          value,
          style: AppTextStyles.bodyBold(),
          textAlign: TextAlign.center,
        ),
        Text(
          label,
          style: AppTextStyles.captionRegular(
            color: context.textSecondaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ── Skills Section ─────────────────────────────────────────────────────────

class _SkillsSection extends StatelessWidget {
  const _SkillsSection({
    required this.skillProfiles,
    required this.isLoading,
    required this.error,
    required this.onRetry,
  });

  final List<SkillProfileEntity> skillProfiles;
  final bool isLoading;
  final String? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '🎯 المهارات (${skillProfiles.length})',
          style: AppTextStyles.titleMedium(),
        ),
        SizedBox(height: AppSizes.vsm),

        if (isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          )
        else if (error != null)
          Container(
            padding: EdgeInsets.all(AppSizes.md),
            decoration: BoxDecoration(
              color: context.errorColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  '⚠️ $error',
                  style: AppTextStyles.bodyRegular(color: context.errorColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSizes.vsm),
                TextButton(
                  onPressed: onRetry,
                  child: Text(
                    'إعادة المحاولة',
                    style: AppTextStyles.bodyRegular(
                      color: context.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        else if (skillProfiles.isEmpty)
          Container(
            padding: EdgeInsets.all(AppSizes.vlg),
            child: Column(
              children: [
                Icon(
                  Icons.school_outlined,
                  color: context.textHintColor,
                  size: 48.r,
                ),
                SizedBox(height: AppSizes.vsm),
                Text(
                  'لا توجد مهارات في هذه المادة',
                  style: AppTextStyles.bodyRegular(
                    color: context.textSecondaryColor,
                  ),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: skillProfiles.length,
            separatorBuilder: (_, __) => SizedBox(height: AppSizes.vxs),
            itemBuilder: (context, index) {
              final profile = skillProfiles[index];
              return _SkillProfileCard(profile: profile);
            },
          ),
      ],
    );
  }
}

// ── Skill Profile Card ─────────────────────────────────────────────────────

class _SkillProfileCard extends StatelessWidget {
  const _SkillProfileCard({required this.profile});

  final SkillProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    final isStarted = profile.isStarted;
    final level = profile.currentLevel;
    final levelLabel = level ?? 'لم يبدأ';
    final score = profile.assessmentScore ?? 0;
    final isMastered = profile.isMastered ?? false;
    final levelColor = _GradientPalette.forLevel(context, level);

    return Container(
      padding: EdgeInsets.all(AppSizes.sm),
      decoration: BoxDecoration(
        color: context.cardBackgroundColor.withOpacity(isStarted ? 1.0 : 0.6),
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        border: Border.all(
          color:
              isStarted
                  ? context.borderColor
                  : context.borderColor.withOpacity(0.3),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(profile.skill.name, style: AppTextStyles.bodyBold()),
              Row(
                children: [
                  if (isMastered)
                    Icon(
                      Icons.verified_rounded,
                      color: context.successColor,
                      size: 16.r,
                    ),
                  if (isMastered) SizedBox(width: AppSizes.xs),
                  if (isStarted)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.xs,
                        vertical: AppSizes.vxs / 2,
                      ),
                      decoration: BoxDecoration(
                        color: levelColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppSizes.radiusXs),
                        border: Border.all(
                          color: levelColor.withOpacity(0.3),
                          width: 0.5.w,
                        ),
                      ),
                      child: Text(
                        levelLabel,
                        style: AppTextStyles.captionRegular(color: levelColor),
                      ),
                    )
                  else
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.xs,
                        vertical: AppSizes.vxs / 2,
                      ),
                      decoration: BoxDecoration(
                        color: context.textHintColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppSizes.radiusXs),
                      ),
                      child: Text(
                        'لم يبدأ',
                        style: AppTextStyles.captionRegular(
                          color: context.textHintColor,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppSizes.vxs),

          // Description
          Text(
            profile.skill.description,
            style: AppTextStyles.captionMedium(
              color: context.textSecondaryColor,
            ),

            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          if (isStarted) ...[
            SizedBox(height: AppSizes.vxs),

            // Score and XP Row
            Row(
              children: [
                Expanded(
                  child: _SkillStat(
                    label: 'التقييم',
                    value: '${score.toStringAsFixed(0)}%',
                    color:
                        score >= 70 ? context.successColor : context.errorColor,
                  ),
                ),

                Expanded(
                  child: _SkillStat(
                    label: 'نقاط الخبرة',
                    value: '${profile.xpTotal ?? 0}',
                    color: context.primaryLightColor,
                  ),
                ),

                Expanded(
                  child: _SkillStat(
                    label: 'التقييمات',
                    value: '${profile.totalAssessments ?? 0}',
                    color: context.primaryColor,
                  ),
                ),
              ],
            ),

            // Progress Indicator
            SizedBox(height: AppSizes.vxs),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusXs),
              child: LinearProgressIndicator(
                value: score / 100,
                backgroundColor: context.borderColor,
                color: score >= 70 ? context.successColor : context.errorColor,
                minHeight: 4.h,
              ),
            ),

            // Last assessment info
            if (profile.lastAssessedAt != null) ...[
              SizedBox(height: AppSizes.vxs),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    _formatDate(profile.lastAssessedAt!.toString()),
                    style: AppTextStyles.captionRegular(
                      color: context.textHintColor,
                    ),
                  ),
                  SizedBox(width: AppSizes.xs),
                  Text(
                    'آخر تقييم:',
                    style: AppTextStyles.captionRegular(
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ],

            // Can reassess info
            if (profile.canReassessAt != null) ...[
              SizedBox(height: AppSizes.vxs),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.xs,
                  vertical: AppSizes.vxs / 2,
                ),
                decoration: BoxDecoration(
                  color: context.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusXs),
                ),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: context.primaryColor,
                      size: 14.r,
                    ),
                    SizedBox(width: AppSizes.xs),
                    Text(
                      'يمكنك إعادة التقييم ${_formatDate(profile.canReassessAt!.toString())}',
                      style: AppTextStyles.captionRegular(
                        color: context.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return 'منذ ${difference.inDays} يوم';
      } else if (difference.inHours > 0) {
        return 'منذ ${difference.inHours} ساعة';
      } else if (difference.inMinutes > 0) {
        return 'منذ ${difference.inMinutes} دقيقة';
      } else {
        return 'الآن';
      }
    } catch (e) {
      return dateString;
    }
  }
}

class _SkillStat extends StatelessWidget {
  const _SkillStat({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: AppTextStyles.bodyBold(color: color),
          textAlign: TextAlign.center,
        ),
        Text(
          label,
          style: AppTextStyles.captionRegular(
            color: context.textSecondaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
