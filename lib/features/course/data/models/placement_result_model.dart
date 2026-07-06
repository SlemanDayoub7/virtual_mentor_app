import '../../domain/entities/placement_result_entity.dart';
import 'concept_score_model.dart';
import 'difficulty_score_model.dart';
import 'question_review_model.dart';
import 'weak_concept_model.dart';

class PlacementResultModel extends PlacementResultEntity {
  const PlacementResultModel({
    required super.score,
    required super.level,
    required super.correctCount,
    required super.totalCount,
    required super.byDifficulty,
    required super.byConcept,
    required super.weakConcepts,
    required super.canReassessAt,
    required super.xpEarned,
    required super.questionsReview,
  });

  factory PlacementResultModel.fromJson(Map<String, dynamic> json) {
    final byDifficultyJson =
        json['by_difficulty'] as Map<String, dynamic>? ?? {};

    return PlacementResultModel(
      score: json['score'] as int? ?? 0,
      level: json['level'] as String? ?? '',
      correctCount: json['correct_count'] as int? ?? 0,
      totalCount: json['total_count'] as int? ?? 0,
      byDifficulty: byDifficultyJson.map(
        (key, value) => MapEntry(
          key,
          DifficultyScoreModel.fromJson(value as Map<String, dynamic>),
        ),
      ),
      byConcept:
          (json['by_concept'] as List<dynamic>? ?? [])
              .map((e) => ConceptScoreModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      weakConcepts:
          (json['weak_concepts'] as List<dynamic>? ?? [])
              .map((e) => WeakConceptModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      canReassessAt:
          json['can_reassess_at'] != null
              ? DateTime.tryParse(json['can_reassess_at'] as String)
              : null,
      xpEarned: json['xp_earned'] as int? ?? 0,
      questionsReview:
          (json['questions_review'] as List<dynamic>? ?? [])
              .map(
                (e) => QuestionReviewModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );
  }
}
