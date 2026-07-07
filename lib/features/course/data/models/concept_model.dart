import '../../domain/entities/concept_entity.dart';

class ConceptModel extends ConceptEntity {
  const ConceptModel({
    required super.id,
    required super.level,
    required super.name,
    required super.explanation,
    required super.referenceTitle,
    required super.referenceUrl,
    required super.referenceType,
  });

  factory ConceptModel.fromJson(Map<String, dynamic> json) => ConceptModel(
    id: json['id'] as int,
    level: json['level'] as String? ?? '',
    name: json['name'] as String? ?? '',
    explanation: json['explanation'] as String? ?? '',
    referenceTitle: json['reference_title'] as String? ?? '',
    referenceUrl: json['reference_url'] as String? ?? '',
    referenceType: json['reference_type'] as String? ?? '',
  );
}
