import 'package:virtual_mentor_app/core/networking/api_result.dart';
import '../entities/category_entity.dart';
import '../entities/subject_entity.dart';
import '../entities/skill_entity.dart';

abstract class CourseRepository {
  Future<ApiResult<List<CategoryEntity>>> getCategories();
  Future<ApiResult<List<SubjectEntity>>> getSubjectsByCategory(int categoryId);
  Future<ApiResult<List<SkillEntity>>> getSkillsBySubject(
    int categoryId,
    int subjectId,
  );
}
