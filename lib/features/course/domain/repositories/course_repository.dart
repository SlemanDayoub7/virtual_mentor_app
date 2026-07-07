import 'package:virtual_mentor_app/core/networking/api_result.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/progress_overview_entity.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/skill_entity.dart';
import '../entities/category_entity.dart';
import '../entities/category_progress_entity.dart';
import '../entities/concept_profile_entity.dart';
import '../entities/placement_answer_entity.dart';
import '../entities/placement_result_entity.dart';
import '../entities/placement_session_entity.dart';
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
  Future<ApiResult<ProgressOverviewEntity>> getProgressOverview();

  Future<ApiResult<List<SkillProfileEntity>>> getSkillProfilesBySubject(
    int categoryId,
    int subjectId,
  );

  Future<ApiResult<List<ConceptProfileEntity>>> getConceptProfiles(
    int categoryId,
    int subjectId,
    int skillId,
  );

  Future<ApiResult<PlacementSessionEntity>> startPlacement(
    int categoryId,
    int subjectId,
    int skillId,
  );

  Future<ApiResult<PlacementResultEntity>> submitPlacement(
    int placementId,
    List<PlacementAnswerEntity> answers,
  );
}
