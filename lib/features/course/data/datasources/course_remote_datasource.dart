import 'package:virtual_mentor_app/core/networking/api_constants.dart';
import 'package:virtual_mentor_app/core/networking/dio_client.dart';
import 'package:virtual_mentor_app/features/course/data/models/progress_overview_model.dart';
import '../models/category_model.dart';
import '../models/category_progress_model.dart';
import '../models/skill_profile_model.dart';
import '../models/subject_model.dart';

abstract class CourseRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<SubjectModel>> getSubjectsByCategory(int categoryId);
  Future<List<SkillModel>> getSkillsBySubject(int categoryId, int subjectId);
  Future<CategoryProgressModel> getCategoryProgress(int categoryId);

  // New method for skill profiles
  Future<List<SkillProfileModel>> getSkillProfiles();
  Future<ProgressOverviewModel> getProgressOverview();
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final DioClient _client;
  const CourseRemoteDataSourceImpl(this._client);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _client.dio.get(ApiConstants.categories);
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<SubjectModel>> getSubjectsByCategory(int categoryId) async {
    final response = await _client.dio.get(
      ApiConstants.getSubjectsByCategory(categoryId),
    );
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => SubjectModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<SkillModel>> getSkillsBySubject(
    int categoryId,
    int subjectId,
  ) async {
    final response = await _client.dio.get(
      ApiConstants.getSkillsBySubject(categoryId, subjectId),
    );
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => SkillModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<CategoryProgressModel> getCategoryProgress(int categoryId) async {
    final response = await _client.dio.get(
      ApiConstants.getCategoryProgress(categoryId),
    );
    return CategoryProgressModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<List<SkillProfileModel>> getSkillProfiles() async {
    final response = await _client.dio.get(ApiConstants.getSkillProfiles());
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => SkillProfileModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
  @override
   Future<ProgressOverviewModel>getProgressOverview() async {
    final response = await _client.dio.get(ApiConstants.getProgressOverview());
   return ProgressOverviewModel.fromJson(response.data as Map<String, dynamic>);
  }
}
