import 'package:virtual_mentor_app/core/networking/api_result.dart';
import '../entities/category_progress_entity.dart';
import '../repositories/course_repository.dart';

class GetCategoryProgressUseCase {
  final CourseRepository _repository;
  const GetCategoryProgressUseCase(this._repository);

  Future<ApiResult<CategoryProgressEntity>> call(int categoryId) =>
      _repository.getCategoryProgress(categoryId);
}
