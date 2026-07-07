class QuestionReviewEntity {
  final int questionId;
  final String question;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;
  final String levelQuestion;
  final String conceptName;

  const QuestionReviewEntity({
    required this.questionId,
    required this.question,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    required this.levelQuestion,
    required this.conceptName,
  });
}
