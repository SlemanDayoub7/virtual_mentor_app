import 'concept_score_entity.dart';
import 'difficulty_score_entity.dart';
import 'question_review_entity.dart';
import 'weak_concept_entity.dart';

class PlacementResultEntity {
  final int score;
  final String level;
  final int correctCount;
  final int totalCount;
  final Map<String, DifficultyScoreEntity> byDifficulty;
  final List<ConceptScoreEntity> byConcept;
  final List<WeakConceptEntity> weakConcepts;
  final DateTime? canReassessAt;
  final int xpEarned;
  final List<QuestionReviewEntity> questionsReview;

  const PlacementResultEntity({
    required this.score,
    required this.level,
    required this.correctCount,
    required this.totalCount,
    required this.byDifficulty,
    required this.byConcept,
    required this.weakConcepts,
    required this.canReassessAt,
    required this.xpEarned,
    required this.questionsReview,
  });
}
