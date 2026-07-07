import 'skill_brief_entity.dart';

class SkillProfileEntity {
  final int id;
  final SkillBriefEntity skill;
  final bool isStarted;
  final String? currentLevel;
  final int? assessmentScore;
  final bool? isMastered;
  final DateTime? masteredAt;
  final int? totalAssessments;
  final DateTime? lastAssessedAt;
  final DateTime? canReassessAt;
  final int? xpTotal;

  const SkillProfileEntity({
    required this.id,
    required this.skill,
    required this.isStarted,
    this.currentLevel,
    this.assessmentScore,
    this.isMastered,
    this.masteredAt,
    this.totalAssessments,
    this.lastAssessedAt,
    this.canReassessAt,
    this.xpTotal,
  });
}
