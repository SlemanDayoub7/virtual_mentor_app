import 'package:virtual_mentor_app/core/networking/api_result.dart';
import 'package:virtual_mentor_app/core/networking/safe_api_call.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/progress_overview_entity.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/skill_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/category_progress_entity.dart';
import '../../domain/entities/concept_profile_entity.dart';
import '../../domain/entities/placement_answer_entity.dart';
import '../../domain/entities/placement_result_entity.dart';
import '../../domain/entities/placement_session_entity.dart';
import '../../domain/entities/skill_profile_entity.dart';
import '../../domain/entities/subject_entity.dart';

import '../../domain/repositories/course_repository.dart';
import '../datasources/course_remote_datasource.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource _dataSource;
  const CourseRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<List<CategoryEntity>>> getCategories() =>
      safeApiCall(() => _dataSource.getCategories());

  @override
  Future<ApiResult<List<SubjectEntity>>> getSubjectsByCategory(
    int categoryId,
  ) => safeApiCall(() => _dataSource.getSubjectsByCategory(categoryId));

  @override
  Future<ApiResult<List<SkillEntity>>> getSkillsBySubject(
    int categoryId,
    int subjectId,
  ) => safeApiCall(() => _dataSource.getSkillsBySubject(categoryId, subjectId));

  @override
  Future<ApiResult<CategoryProgressEntity>> getCategoryProgress(
    int categoryId,
  ) => safeApiCall(() => _dataSource.getCategoryProgress(categoryId));

  @override
  Future<ApiResult<ProgressOverviewEntity>> getProgressOverview() =>
      safeApiCall(() => _dataSource.getProgressOverview());

  @override
  Future<ApiResult<List<SkillProfileEntity>>> getSkillProfilesBySubject(
    int categoryId,
    int subjectId,
  ) => safeApiCall(
    () => _dataSource.getSkillProfilesBySubject(categoryId, subjectId),
  );

  @override
  Future<ApiResult<List<ConceptProfileEntity>>> getConceptProfiles(
    int categoryId,
    int subjectId,
    int skillId,
  ) => safeApiCall(
    () => _dataSource.getConceptProfiles(categoryId, subjectId, skillId),
  );

  @override
  Future<ApiResult<PlacementSessionEntity>> startPlacement(
    int categoryId,
    int subjectId,
    int skillId,
  ) => safeApiCall(
    () => _dataSource.startPlacement(categoryId, subjectId, skillId),
  );

  @override
  Future<ApiResult<PlacementResultEntity>> submitPlacement(
    int placementId,
    List<PlacementAnswerEntity> answers,
  ) => safeApiCall(() => _dataSource.submitPlacement(placementId, answers));
}
