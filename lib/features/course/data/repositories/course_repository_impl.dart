import 'package:virtual_mentor_app/core/networking/api_result.dart';
import 'package:virtual_mentor_app/core/networking/safe_api_call.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/subject_entity.dart';
import '../../domain/entities/skill_entity.dart';
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
}
