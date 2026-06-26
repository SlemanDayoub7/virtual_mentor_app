import '../../domain/entities/subject_entity.dart';

class SubjectModel extends SubjectEntity {
  const SubjectModel({
    required super.id,

    required super.name,
    required super.description,
    required super.icon,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
    id: json['id'] as int,

    name: json['name'] as String,
    description: json['description'] as String? ?? '',
    icon: json['icon'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,

    'name': name,
    'description': description,
    'icon': icon,
  };
}
