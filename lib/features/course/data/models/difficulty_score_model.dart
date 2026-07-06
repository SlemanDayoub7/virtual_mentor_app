import '../../domain/entities/difficulty_score_entity.dart';

class DifficultyScoreModel extends DifficultyScoreEntity {
  const DifficultyScoreModel({
    required super.correct,
    required super.total,
    required super.score,
  });

  factory DifficultyScoreModel.fromJson(Map<String, dynamic> json) =>
      DifficultyScoreModel(
        correct: json['correct'] as int? ?? 0,
        total: json['total'] as int? ?? 0,
        score: json['score'] as int? ?? 0,
      );
}
