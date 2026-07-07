import '../../domain/entities/concept_score_entity.dart';

class ConceptScoreModel extends ConceptScoreEntity {
  const ConceptScoreModel({
    required super.conceptId,
    required super.conceptName,
    required super.score,
    required super.status,
  });

  factory ConceptScoreModel.fromJson(Map<String, dynamic> json) =>
      ConceptScoreModel(
        conceptId: json['concept_id'] as int,
        conceptName: json['concept_name'] as String? ?? '',
        score: json['score'] as int? ?? 0,
        status: json['status'] as String? ?? '',
      );
}
