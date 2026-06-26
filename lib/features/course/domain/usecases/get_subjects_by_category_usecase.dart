import 'package:virtual_mentor_app/core/networking/api_result.dart';
import '../entities/subject_entity.dart';
import '../repositories/course_repository.dart';

class GetSubjectsByCategoryUseCase {
  final CourseRepository _repository;
  const GetSubjectsByCategoryUseCase(this._repository);

  Future<ApiResult<List<SubjectEntity>>> call(int categoryId) =>
      _repository.getSubjectsByCategory(categoryId);
}
