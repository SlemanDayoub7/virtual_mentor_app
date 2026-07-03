import 'package:virtual_mentor_app/core/networking/api_result.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/progress_overview_entity.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/skill_entity.dart';
import '../entities/category_entity.dart';
import '../entities/category_progress_entity.dart';
import '../entities/skill_profile_entity.dart';
import '../entities/subject_entity.dart';

abstract class CourseRepository {
  Future<ApiResult<List<CategoryEntity>>> getCategories();
  Future<ApiResult<List<SubjectEntity>>> getSubjectsByCategory(int categoryId);
  Future<ApiResult<List<SkillEntity>>> getSkillsBySubject(
    int categoryId,
    int subjectId,
  );
  Future<ApiResult<CategoryProgressEntity>> getCategoryProgress(int categoryId);

  Future<ApiResult<List<SkillProfileEntity>>> getSkillProfiles();

  Future<ApiResult<ProgressOverviewEntity>> getProgressOverview();
}
