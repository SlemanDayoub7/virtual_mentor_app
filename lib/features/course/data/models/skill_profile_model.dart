import '../../domain/entities/skill_profile_entity.dart';
import 'skill_brief_model.dart';

class SkillProfileModel extends SkillProfileEntity {
  const SkillProfileModel({
    required super.id,
    required super.skill,
    required super.isStarted,
    super.currentLevel,
    super.assessmentScore,
    super.isMastered,
    super.masteredAt,
    super.totalAssessments,
    super.lastAssessedAt,
    super.canReassessAt,
    super.xpTotal,
  });

  factory SkillProfileModel.fromJson(Map<String, dynamic> json) =>
      SkillProfileModel(
        id: json['id'] as int,
        skill: SkillBriefModel.fromJson(json['skill'] as Map<String, dynamic>),
        isStarted: json['is_started'] as bool? ?? false,
        currentLevel: json['current_level'] as String?,
        assessmentScore: json['assessment_score'] as int?,
        isMastered: json['is_mastered'] as bool?,
        masteredAt:
            json['mastered_at'] != null
                ? DateTime.tryParse(json['mastered_at'] as String)
                : null,
        totalAssessments: json['total_assessments'] as int?,
        lastAssessedAt:
            json['last_assessed_at'] != null
                ? DateTime.tryParse(json['last_assessed_at'] as String)
                : null,
        canReassessAt:
            json['can_reassess_at'] != null
                ? DateTime.tryParse(json['can_reassess_at'] as String)
                : null,
        xpTotal: json['xp_total'] as int?,
      );
}
