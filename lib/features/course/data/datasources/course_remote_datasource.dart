import 'package:virtual_mentor_app/core/networking/dio_client.dart';
import '../models/category_model.dart';
import '../models/subject_model.dart';
import '../models/skill_model.dart';

abstract class CourseRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<SubjectModel>> getSubjectsByCategory(int categoryId);
  Future<List<SkillModel>> getSkillsBySubject(int categoryId, int subjectId);
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final DioClient _client;
  const CourseRemoteDataSourceImpl(this._client);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _client.dio.get('/api/categories/');
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<SubjectModel>> getSubjectsByCategory(int categoryId) async {
    final response = await _client.dio.get(
      '/api/categories/$categoryId/subjects/',
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
      '/api/categories/$categoryId/subjects/$subjectId/skills/',
    );
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => SkillModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
