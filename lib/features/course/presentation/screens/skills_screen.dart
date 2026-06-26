// lib/features/course/presentation/screens/skills_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/core/di/injection_container.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/core/widgets/loading/app_loading.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/skill_entity.dart';
import '../../domain/entities/subject_entity.dart';
import '../blocs/skill/skill_bloc.dart';
import '../widgets/skill_card.dart';

class SkillsScreen extends StatefulWidget {
  final SubjectEntity subject;
  const SkillsScreen({super.key, required this.subject});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  late final SkillBloc _skillBloc;

  @override
  void initState() {
    super.initState();
    _skillBloc =
        sl<SkillBloc>()..add(
          GetSkillsBySubject(
            subjectId: widget.subject.id,
            categoryId: widget.subject.category ?? 0,
          ),
        );
  }

  @override
  void dispose() {
    _skillBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject.name, style: AppTextStyles.headingM()),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocProvider.value(
        value: _skillBloc,
        child: BlocBuilder<SkillBloc, SkillState>(
          builder: (context, state) {
            if (state is SkillLoading) {
              return const AppLoader(message: 'جاري تحميل المهارات...');
            } else if (state is SkillLoaded) {
              return _buildSkillsList(state.skills);
            } else if (state is SkillFailure) {
              return _buildErrorWidget(state.message);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildSkillsList(List<SkillEntity> skills) {
    if (skills.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.psychology_outlined,
              size: 64.w,
              color: context.textSecondaryColor,
            ),
            SizedBox(height: AppSizes.md.h),
            Text(
              'لا توجد مهارات متاحة',
              style: AppTextStyles.bodyL(color: context.textSecondaryColor),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(AppSizes.md.r),
      itemCount: skills.length,
      itemBuilder: (context, index) {
        return SkillCard(
          skill: skills[index],
          onTap: () {
            _showSkillDetails(context, skills[index]);
          },
        );
      },
    );
  }

  void _showSkillDetails(BuildContext context, SkillEntity skill) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            decoration: BoxDecoration(
              color: context.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSizes.radiusMd.r),
                topRight: Radius.circular(AppSizes.radiusMd.r),
              ),
            ),
            padding: EdgeInsets.all(AppSizes.lg.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: context.textSecondaryColor,
                      borderRadius: BorderRadius.circular(AppSizes.radiusMd.r),
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.lg.h),
                Text(skill.name, style: AppTextStyles.headingM()),
                SizedBox(height: AppSizes.md.h),
                Text(
                  skill.description.isNotEmpty
                      ? skill.description
                      : 'لا يوجد وصف متاح',
                  style: AppTextStyles.bodyL(color: context.textSecondaryColor),
                ),
                SizedBox(height: AppSizes.xl.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // TODO: Start learning
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: AppSizes.md.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusMd.r,
                        ),
                      ),
                    ),
                    child: Text(
                      'ابدأ التعلم',
                      style: AppTextStyles.button(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64.w, color: AppColors.error),
          SizedBox(height: AppSizes.md.h),
          Text(
            message,
            style: AppTextStyles.bodyL(color: context.textSecondaryColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSizes.lg.h),
          ElevatedButton(
            onPressed: () {
              _skillBloc.add(
                GetSkillsBySubject(
                  subjectId: widget.subject.id,
                  categoryId: widget.subject.category ?? 0,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMd.r),
              ),
            ),
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }
}
