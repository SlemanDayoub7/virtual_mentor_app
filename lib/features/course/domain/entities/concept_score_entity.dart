class ConceptScoreEntity {
  final int conceptId;
  final String conceptName;
  final int score;
  final String status;

  const ConceptScoreEntity({
    required this.conceptId,
    required this.conceptName,
    required this.score,
    required this.status,
  });
}
