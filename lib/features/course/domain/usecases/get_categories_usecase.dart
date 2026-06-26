import 'package:virtual_mentor_app/core/networking/api_result.dart';
import '../entities/category_entity.dart';
import '../repositories/course_repository.dart';

class GetCategoriesUseCase {
  final CourseRepository _repository;
  const GetCategoriesUseCase(this._repository);

  Future<ApiResult<List<CategoryEntity>>> call() => _repository.getCategories();
}
