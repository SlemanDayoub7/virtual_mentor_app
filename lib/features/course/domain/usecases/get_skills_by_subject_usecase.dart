import 'package:virtual_mentor_app/core/networking/api_result.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/skill_entity.dart';

import '../repositories/course_repository.dart';

class GetSkillsBySubjectUseCase {
  final CourseRepository _repository;
  const GetSkillsBySubjectUseCase(this._repository);

  Future<ApiResult<List<SkillEntity>>> call(int categoryId, int subjectId) =>
      _repository.getSkillsBySubject(categoryId, subjectId);
}
