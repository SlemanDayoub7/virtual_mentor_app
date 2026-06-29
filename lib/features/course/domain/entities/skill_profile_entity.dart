import 'package:virtual_mentor_app/features/course/domain/entities/skill_entity.dart';

class SkillProfileEntity {
  final int id;
  final SkillEntity skill;
  final bool isStarted;
  final String? currentLevel;
  final double? assessmentScore;
  final bool? isMastered;
  final String? masteredAt;
  final int? totalAssessments;
  final String? lastAssessedAt;
  final String? canReassessAt;
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
