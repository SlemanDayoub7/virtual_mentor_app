import '../../domain/entities/concept_profile_entity.dart';
import 'concept_model.dart';

class ConceptProfileModel extends ConceptProfileEntity {
  const ConceptProfileModel({
    required super.id,
    required super.concept,
    required super.status,
    required super.avgScore,
    required super.timesTrained,
    required super.updatedAt,
  });

  factory ConceptProfileModel.fromJson(Map<String, dynamic> json) =>
      ConceptProfileModel(
        id: json['id'] as int,
        concept: ConceptModel.fromJson(json['concept'] as Map<String, dynamic>),
        status: json['status'] as String? ?? '',
        avgScore: json['avg_score'] as int? ?? 0,
        timesTrained: json['times_trained'] as int? ?? 0,
        updatedAt:
            DateTime.tryParse(json['updated_at'] as String? ?? '') ??
            DateTime.now(),
      );
}
