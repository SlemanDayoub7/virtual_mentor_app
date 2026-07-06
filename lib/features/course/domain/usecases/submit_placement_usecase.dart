import 'package:virtual_mentor_app/core/networking/api_result.dart';
import '../entities/placement_answer_entity.dart';
import '../entities/placement_result_entity.dart';
import '../repositories/course_repository.dart';

class SubmitPlacementUseCase {
  final CourseRepository _repository;
  const SubmitPlacementUseCase(this._repository);

  Future<ApiResult<PlacementResultEntity>> call(
    int placementId,
    List<PlacementAnswerEntity> answers,
  ) => _repository.submitPlacement(placementId, answers);
}
