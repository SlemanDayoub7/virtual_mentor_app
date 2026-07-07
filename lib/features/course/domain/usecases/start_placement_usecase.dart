import 'package:virtual_mentor_app/core/networking/api_result.dart';
import '../entities/placement_session_entity.dart';
import '../repositories/course_repository.dart';

class StartPlacementUseCase {
  final CourseRepository _repository;
  const StartPlacementUseCase(this._repository);

  Future<ApiResult<PlacementSessionEntity>> call(
    int categoryId,
    int subjectId,
    int skillId,
  ) => _repository.startPlacement(categoryId, subjectId, skillId);
}
