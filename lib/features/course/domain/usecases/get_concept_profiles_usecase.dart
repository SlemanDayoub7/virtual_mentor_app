import 'package:virtual_mentor_app/core/networking/api_result.dart';
import '../entities/concept_profile_entity.dart';
import '../repositories/course_repository.dart';

class GetConceptProfilesUseCase {
  final CourseRepository _repository;
  const GetConceptProfilesUseCase(this._repository);

  Future<ApiResult<List<ConceptProfileEntity>>> call(
    int categoryId,
    int subjectId,
    int skillId,
  ) => _repository.getConceptProfiles(categoryId, subjectId, skillId);
}
