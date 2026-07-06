import '../../domain/entities/question_entity.dart';

class QuestionModel extends QuestionEntity {
  const QuestionModel({
    required super.id,
    required super.question,
    required super.questionType,
    required super.level,
    required super.conceptName,
    required super.options,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    id: json['id'] as int,
    question: json['question'] as String? ?? '',
    questionType: json['question_type'] as String? ?? '',
    level: json['level'] as String? ?? '',
    conceptName: json['concept_name'] as String? ?? '',
    options:
        (json['options'] as List<dynamic>? ?? [])
            .map((e) => e as String)
            .toList(),
  );
}
