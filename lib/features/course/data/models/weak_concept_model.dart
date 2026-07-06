import '../../domain/entities/weak_concept_entity.dart';

class WeakConceptModel extends WeakConceptEntity {
  const WeakConceptModel({required super.id, required super.name});

  factory WeakConceptModel.fromJson(Map<String, dynamic> json) =>
      WeakConceptModel(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
      );
}
