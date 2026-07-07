import 'placement_question_entity.dart';

class PlacementSessionEntity {
  final int id;
  final int skill;
  final DateTime startedAt;
  final List<PlacementQuestionEntity> questions;

  const PlacementSessionEntity({
    required this.id,
    required this.skill,
    required this.startedAt,
    required this.questions,
  });
}
