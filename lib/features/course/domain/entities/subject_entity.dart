class SubjectEntity {
  final int id;
  final int? category;
  final String name;
  final String description;
  final String icon;

  const SubjectEntity({
    required this.id,
    this.category,
    required this.name,
    required this.description,
    required this.icon,
  });

  SubjectEntity copyWith({
    int? id,
    int? category,
    String? name,
    String? description,
    String? icon,
  }) {
    return SubjectEntity(
      id: id ?? this.id,
      category: category ?? this.category,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }
}
