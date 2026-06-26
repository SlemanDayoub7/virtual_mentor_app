import '../../domain/entities/skill_entity.dart';

class SkillModel extends SkillEntity {
  const SkillModel({
    required super.id,

    required super.name,
    required super.description,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) => SkillModel(
    id: json['id'] as int,

    name: json['name'] as String,
    description: json['description'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,

    'name': name,
    'description': description,
  };
}
