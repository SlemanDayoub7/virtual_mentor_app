// lib/features/course/presentation/screens/subjects_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_mentor_app/core/di/injection_container.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/core/widgets/loading/app_loading.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/subject_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../blocs/subject/subject_bloc.dart';
import '../widgets/subject_card.dart';

class SubjectsScreen extends StatefulWidget {
  final CategoryEntity category;
  const SubjectsScreen({super.key, required this.category});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  late final SubjectBloc _subjectBloc;

  @override
  void initState() {
    super.initState();
    _subjectBloc =
        sl<SubjectBloc>()..add(GetSubjectsByCategory(widget.category.id));
  }

  @override
  void dispose() {
    _subjectBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name, style: AppTextStyles.headingM()),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocProvider.value(
        value: _subjectBloc,
        child: BlocBuilder<SubjectBloc, SubjectState>(
          builder: (context, state) {
            if (state is SubjectLoading) {
              return const AppLoader(message: 'جاري تحميل المواد...');
            } else if (state is SubjectLoaded) {
              return _buildSubjectsList(state.subjects);
            } else if (state is SubjectFailure) {
              return _buildErrorWidget(state.message);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildSubjectsList(List<SubjectEntity> subjects) {
    if (subjects.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: 64.w,
              color: context.textSecondaryColor,
            ),
            SizedBox(height: AppSizes.md.h),
            Text(
              'لا توجد مواد متاحة',
              style: AppTextStyles.bodyL(color: context.textSecondaryColor),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(AppSizes.md.r),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        return SubjectCard(
          subject: subjects[index],
          onTap: () {
            context.push(
              '/categories/${widget.category.id}/subjects/${subjects[index].id}/skills',
              extra: subjects[index].copyWith(category: widget.category.id),
            );
          },
        );
      },
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
              _subjectBloc.add(GetSubjectsByCategory(widget.category.id));
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
