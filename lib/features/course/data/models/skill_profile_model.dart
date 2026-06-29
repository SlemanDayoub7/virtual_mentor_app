import 'package:virtual_mentor_app/features/course/domain/entities/skill_entity.dart';

import '../../domain/entities/skill_profile_entity.dart';

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

  factory SkillProfileModel.fromJson(Map<String, dynamic> json) {
    return SkillProfileModel(
      id: json['id'] as int,
      skill: SkillModel.fromJson(json['skill'] as Map<String, dynamic>),
      isStarted: json['is_started'] as bool,
      currentLevel: json['current_level'] as String?,
      assessmentScore: (json['assessment_score'] as num?)?.toDouble(),
      isMastered: json['is_mastered'] as bool?,
      masteredAt: json['mastered_at'] as String?,
      totalAssessments: json['total_assessments'] as int?,
      lastAssessedAt: json['last_assessed_at'] as String?,
      canReassessAt: json['can_reassess_at'] as String?,
      xpTotal: json['xp_total'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'skill': (skill as SkillModel).toJson(),
    'is_started': isStarted,
    'current_level': currentLevel,
    'assessment_score': assessmentScore,
    'is_mastered': isMastered,
    'mastered_at': masteredAt,
    'total_assessments': totalAssessments,
    'last_assessed_at': lastAssessedAt,
    'can_reassess_at': canReassessAt,
    'xp_total': xpTotal,
  };
}

class SkillModel extends SkillEntity {
  const SkillModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
  };
}
