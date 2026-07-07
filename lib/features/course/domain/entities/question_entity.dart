class QuestionEntity {
  final int id;
  final String question;
  final String questionType;
  final String level;
  final String conceptName;
  final List<String> options;

  const QuestionEntity({
    required this.id,
    required this.question,
    required this.questionType,
    required this.level,
    required this.conceptName,
    required this.options,
  });
}
