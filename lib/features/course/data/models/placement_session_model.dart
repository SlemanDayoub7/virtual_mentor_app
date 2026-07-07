import '../../domain/entities/placement_session_entity.dart';
import 'placement_question_model.dart';

class PlacementSessionModel extends PlacementSessionEntity {
  const PlacementSessionModel({
    required super.id,
    required super.skill,
    required super.startedAt,
    required super.questions,
  });

  factory PlacementSessionModel.fromJson(
    Map<String, dynamic> json,
  ) => PlacementSessionModel(
    id: json['id'] as int,
    skill: json['skill'] as int,
    startedAt:
        DateTime.tryParse(json['started_at'] as String? ?? '') ??
        DateTime.now(),
    questions:
        (json['questions'] as List<dynamic>? ?? [])
            .map(
              (e) => PlacementQuestionModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
  );
}
