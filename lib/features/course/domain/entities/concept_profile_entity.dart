import 'concept_entity.dart';

class ConceptProfileEntity {
  final int id;
  final ConceptEntity concept;
  final String status;
  final int avgScore;
  final int timesTrained;
  final DateTime updatedAt;

  const ConceptProfileEntity({
    required this.id,
    required this.concept,
    required this.status,
    required this.avgScore,
    required this.timesTrained,
    required this.updatedAt,
  });
}
