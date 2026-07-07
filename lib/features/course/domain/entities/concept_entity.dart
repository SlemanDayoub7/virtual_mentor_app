class ConceptEntity {
  final int id;
  final String level;
  final String name;
  final String explanation;
  final String referenceTitle;
  final String referenceUrl;
  final String referenceType;

  const ConceptEntity({
    required this.id,
    required this.level,
    required this.name,
    required this.explanation,
    required this.referenceTitle,
    required this.referenceUrl,
    required this.referenceType,
  });
}
