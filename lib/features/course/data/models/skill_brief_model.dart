import '../../domain/entities/skill_brief_entity.dart';

class SkillBriefModel extends SkillBriefEntity {
  const SkillBriefModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory SkillBriefModel.fromJson(Map<String, dynamic> json) =>
      SkillBriefModel(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
        description: json['description'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
  };
}
