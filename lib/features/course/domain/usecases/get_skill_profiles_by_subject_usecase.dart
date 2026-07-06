import 'package:virtual_mentor_app/core/networking/api_result.dart';
import '../entities/skill_profile_entity.dart';
import '../repositories/course_repository.dart';

class GetSkillProfilesBySubjectUseCase {
  final CourseRepository _repository;
  const GetSkillProfilesBySubjectUseCase(this._repository);

  Future<ApiResult<List<SkillProfileEntity>>> call(
    int categoryId,
    int subjectId,
  ) => _repository.getSkillProfilesBySubject(categoryId, subjectId);
}
