import '../../domain/entities/question_review_entity.dart';

class QuestionReviewModel extends QuestionReviewEntity {
  const QuestionReviewModel({
    required super.questionId,
    required super.question,
    required super.userAnswer,
    required super.correctAnswer,
    required super.isCorrect,
    required super.levelQuestion,
    required super.conceptName,
  });

  factory QuestionReviewModel.fromJson(Map<String, dynamic> json) =>
      QuestionReviewModel(
        questionId: json['question_id'] as int,
        question: json['question'] as String? ?? '',
        userAnswer: json['user_answer']?.toString() ?? '',
        correctAnswer: json['correct_answer']?.toString() ?? '',
        isCorrect: json['is_correct'] as bool? ?? false,
        levelQuestion: json['level_question'] as String? ?? '',
        conceptName: json['concept_name'] as String? ?? '',
      );
}
