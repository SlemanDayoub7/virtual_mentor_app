import 'package:virtual_mentor_app/core/networking/api_result.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/progress_overview_entity.dart';
import 'package:virtual_mentor_app/features/course/domain/repositories/course_repository.dart';

class GetProgressOverviewUseCase{
 final CourseRepository _repositry;

 const GetProgressOverviewUseCase(this._repositry);
 Future<ApiResult<ProgressOverviewEntity>> call() =>
 _repositry.getProgressOverview();

}