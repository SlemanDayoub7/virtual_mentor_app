import 'package:virtual_mentor_app/core/networking/api_constants.dart';
import 'package:virtual_mentor_app/core/networking/dio_client.dart';
import 'package:virtual_mentor_app/features/course/data/models/concept_profile_model.dart';
import 'package:virtual_mentor_app/features/course/data/models/placement_result_model.dart';
import 'package:virtual_mentor_app/features/course/data/models/placement_session_model.dart';
import 'package:virtual_mentor_app/features/course/data/models/progress_overview_model.dart';
import 'package:virtual_mentor_app/features/course/data/models/skill_model.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/placement_answer_entity.dart';
import '../models/category_model.dart';
import '../models/category_progress_model.dart';
import '../models/skill_profile_model.dart';
import '../models/subject_model.dart';


abstract class CourseRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<SubjectModel>> getSubjectsByCategory(int categoryId);
  Future<List<SkillModel>> getSkillsBySubject(int categoryId, int subjectId);
  Future<CategoryProgressModel> getCategoryProgress(int categoryId);
  Future<ProgressOverviewModel> getProgressOverview();

  // Skill profiles (subject scoped)
  Future<List<SkillProfileModel>> getSkillProfilesBySubject(
    int categoryId,
    int subjectId,
  );

  // Concept profiles
  Future<List<ConceptProfileModel>> getConceptProfiles(
    int categoryId,
    int subjectId,
    int skillId,
  );

  // Placement
  Future<PlacementSessionModel> startPlacement(
    int categoryId,
    int subjectId,
    int skillId,
  );

  Future<PlacementResultModel> submitPlacement(
    int placementId,
    List<PlacementAnswerEntity> answers,
  );
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
  Future<ProgressOverviewModel> getProgressOverview() async {
    final response = await _client.dio.get(ApiConstants.getProgressOverview());
    return ProgressOverviewModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<List<SkillProfileModel>> getSkillProfilesBySubject(
    int categoryId,
    int subjectId,
  ) async {
    final response = await _client.dio.get(
      ApiConstants.getSkillProfilesBySubject(categoryId, subjectId),
    );
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => SkillProfileModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ConceptProfileModel>> getConceptProfiles(
    int categoryId,
    int subjectId,
    int skillId,
  ) async {
    final response = await _client.dio.get(
      ApiConstants.getConceptProfiles(categoryId, subjectId, skillId),
    );
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map(
          (json) => ConceptProfileModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<PlacementSessionModel> startPlacement(
    int categoryId,
    int subjectId,
    int skillId,
  ) async {
    final response = await _client.dio.post(
      ApiConstants.startPlacement(categoryId, subjectId, skillId),
    );
    return PlacementSessionModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<PlacementResultModel> submitPlacement(
    int placementId,
    List<PlacementAnswerEntity> answers,
  ) async {
    final response = await _client.dio.post(
      ApiConstants.submitPlacement(placementId),
      data: {
        'answers':
            answers
                .map(
                  (a) => {
                    'question_id': a.questionId,
                    'user_answer': a.userAnswer,
                  },
                )
                .toList(),
      },
    );
    return PlacementResultModel.fromJson(response.data as Map<String, dynamic>);
  }
}
