import 'package:virtual_mentor_app/core/networking/api_result.dart';
import '../entities/skill_profile_entity.dart';
import '../repositories/course_repository.dart';

class GetSkillProfilesUseCase {
  final CourseRepository _repository;
  const GetSkillProfilesUseCase(this._repository);

  Future<ApiResult<List<SkillProfileEntity>>> call() =>
      _repository.getSkillProfiles();
}
