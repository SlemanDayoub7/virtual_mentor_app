// lib/features/course/presentation/widgets/skill_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import '../../domain/entities/skill_entity.dart';

class SkillCard extends StatelessWidget {
  final SkillEntity skill;
  final VoidCallback onTap;

  const SkillCard({super.key, required this.skill, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: AppSizes.md.h),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd.r),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd.r),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.md.r),
          child: Row(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd.r),
                ),
                child: Icon(
                  Icons.psychology,
                  size: 28.w,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: AppSizes.md.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(skill.name, style: AppTextStyles.bodyBold()),
                    if (skill.description.isNotEmpty) ...[
                      SizedBox(height: AppSizes.vsm.h),
                      Text(
                        skill.description,
                        style: AppTextStyles.bodyS(
                          color: context.textSecondaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.play_circle_outline,
                size: 24.w,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
