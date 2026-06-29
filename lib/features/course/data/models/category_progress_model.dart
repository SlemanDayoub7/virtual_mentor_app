// lib/data/models/category_progress_model.dart

import '../../domain/entities/category_progress_entity.dart';

class CategoryProgressModel extends CategoryProgressEntity {
  const CategoryProgressModel({
    required super.specialization,
    required super.subjects,
    required super.summary,
  });

  factory CategoryProgressModel.fromJson(Map<String, dynamic> json) {
    return CategoryProgressModel(
      specialization: SpecializationModel.fromJson(
        json['specialization'] as Map<String, dynamic>,
      ),
      subjects:
          (json['subjects'] as List<dynamic>)
              .map(
                (item) =>
                    SubjectProgressModel.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
      summary: SummaryModel.fromJson(json['summary'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'specialization': (specialization as SpecializationModel).toJson(),
    'subjects':
        subjects
            .map((subject) => (subject as SubjectProgressModel).toJson())
            .toList(),
    'summary': (summary as SummaryModel).toJson(),
  };
}

class SpecializationModel extends SpecializationEntity {
  const SpecializationModel({
    required super.id,
    required super.name,
    required super.description,
    required super.icon,
    required super.totalSubjects,
  });

  factory SpecializationModel.fromJson(Map<String, dynamic> json) {
    return SpecializationModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      totalSubjects: json['total_subjects'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'icon': icon,
    'total_subjects': totalSubjects,
  };
}

class SubjectProgressModel extends SubjectProgressEntity {
  const SubjectProgressModel({
    required super.id,
    required super.name,
    required super.description,
    required super.stats,
    required super.quickStats,
    required super.recentActivity,
    required super.status,
  });

  factory SubjectProgressModel.fromJson(Map<String, dynamic> json) {
    return SubjectProgressModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      stats: StatsModel.fromJson(json['stats'] as Map<String, dynamic>),
      quickStats:
          json['quick_stats'] != null
              ? QuickStatsModel.fromJson(
                json['quick_stats'] as Map<String, dynamic>,
              )
              : null,
      recentActivity:
          json['recent_activity'] != null
              ? RecentActivityModel.fromJson(
                json['recent_activity'] as Map<String, dynamic>,
              )
              : null,
      status: json['status'] as String? ?? 'not_started',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'stats': (stats as StatsModel).toJson(),
    'quick_stats':
        quickStats != null ? (quickStats as QuickStatsModel).toJson() : null,
    'recent_activity':
        recentActivity != null
            ? (recentActivity as RecentActivityModel).toJson()
            : null,
    'status': status,
  };
}

class StatsModel extends StatsEntity {
  const StatsModel({
    required super.totalSkills,
    required super.totalConcepts,
    required super.masteredSkills,
    required super.improvingSkills,
    required super.weakSkills,
    required super.notStartedSkills,
    required super.progressPercentage,
    required super.averageScore,
    required super.totalXp,
    required super.lastActivity,
    required super.daysSinceLastActivity,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      totalSkills: json['total_skills'] as int? ?? 0,
      totalConcepts: json['total_concepts'] as int? ?? 0,
      masteredSkills: json['mastered_skills'] as int? ?? 0,
      improvingSkills: json['improving_skills'] as int? ?? 0,
      weakSkills: json['weak_skills'] as int? ?? 0,
      notStartedSkills: json['not_started_skills'] as int? ?? 0,
      progressPercentage:
          (json['progress_percentage'] as num?)?.toDouble() ?? 0.0,
      averageScore: (json['average_score'] as num?)?.toDouble() ?? 0.0,
      totalXp: json['total_xp'] as int? ?? 0,
      lastActivity: json['last_activity'] as String?,
      daysSinceLastActivity: json['days_since_last_activity'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'total_skills': totalSkills,
    'total_concepts': totalConcepts,
    'mastered_skills': masteredSkills,
    'improving_skills': improvingSkills,
    'weak_skills': weakSkills,
    'not_started_skills': notStartedSkills,
    'progress_percentage': progressPercentage,
    'average_score': averageScore,
    'total_xp': totalXp,
    'last_activity': lastActivity,
    'days_since_last_activity': daysSinceLastActivity,
  };
}

class QuickStatsModel extends QuickStatsEntity {
  const QuickStatsModel({
    required super.weakestSkill,
    required super.strongestSkill,
    required super.skillsByLevel,
    required super.nextAssessmentAvailable,
  });

  factory QuickStatsModel.fromJson(Map<String, dynamic> json) {
    return QuickStatsModel(
      weakestSkill:
          json['weakest_skill'] != null
              ? SkillSummaryModel.fromJson(
                json['weakest_skill'] as Map<String, dynamic>,
              )
              : null,
      strongestSkill:
          json['strongest_skill'] != null
              ? SkillSummaryModel.fromJson(
                json['strongest_skill'] as Map<String, dynamic>,
              )
              : null,
      skillsByLevel:
          json['skills_by_level'] != null
              ? SkillsByLevelModel.fromJson(
                json['skills_by_level'] as Map<String, dynamic>,
              )
              : const SkillsByLevelModel(
                beginner: 0,
                intermediate: 0,
                advanced: 0,
              ),
      nextAssessmentAvailable: json['next_assessment_available'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'weakest_skill':
        weakestSkill != null
            ? (weakestSkill as SkillSummaryModel).toJson()
            : null,
    'strongest_skill':
        strongestSkill != null
            ? (strongestSkill as SkillSummaryModel).toJson()
            : null,
    'skills_by_level': (skillsByLevel as SkillsByLevelModel).toJson(),
    'next_assessment_available': nextAssessmentAvailable,
  };
}

class SkillSummaryModel extends SkillSummaryEntity {
  const SkillSummaryModel({
    required super.id,
    required super.name,
    required super.score,
    required super.level,
  });

  factory SkillSummaryModel.fromJson(Map<String, dynamic> json) {
    return SkillSummaryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      score: (json['score'] as num).toDouble(),
      level: json['level'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'score': score,
    'level': level,
  };
}

class SkillsByLevelModel extends SkillsByLevelEntity {
  const SkillsByLevelModel({
    required super.beginner,
    required super.intermediate,
    required super.advanced,
  });

  factory SkillsByLevelModel.fromJson(Map<String, dynamic> json) {
    return SkillsByLevelModel(
      beginner: json['beginner'] as int? ?? 0,
      intermediate: json['intermediate'] as int? ?? 0,
      advanced: json['advanced'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'beginner': beginner,
    'intermediate': intermediate,
    'advanced': advanced,
  };
}

class RecentActivityModel extends RecentActivityEntity {
  const RecentActivityModel({
    required super.lastSkillAssessed,
    required super.lastAssessmentDate,
  });

  factory RecentActivityModel.fromJson(Map<String, dynamic> json) {
    return RecentActivityModel(
      lastSkillAssessed: json['last_skill_assessed'] as String? ?? '',
      lastAssessmentDate: json['last_assessment_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'last_skill_assessed': lastSkillAssessed,
    'last_assessment_date': lastAssessmentDate,
  };
}

class SummaryModel extends SummaryEntity {
  const SummaryModel({
    required super.totalSubjects,
    required super.completedSubjects,
    required super.inProgressSubjects,
    required super.notStartedSubjects,
    required super.overallProgress,
    required super.totalSkills,
    required super.masteredSkills,
    required super.totalXp,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      totalSubjects: json['total_subjects'] as int? ?? 0,
      completedSubjects: json['completed_subjects'] as int? ?? 0,
      inProgressSubjects: json['in_progress_subjects'] as int? ?? 0,
      notStartedSubjects: json['not_started_subjects'] as int? ?? 0,
      overallProgress: (json['overall_progress'] as num?)?.toDouble() ?? 0.0,
      totalSkills: json['total_skills'] as int? ?? 0,
      masteredSkills: json['mastered_skills'] as int? ?? 0,
      totalXp: json['total_xp'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'total_subjects': totalSubjects,
    'completed_subjects': completedSubjects,
    'in_progress_subjects': inProgressSubjects,
    'not_started_subjects': notStartedSubjects,
    'overall_progress': overallProgress,
    'total_skills': totalSkills,
    'mastered_skills': masteredSkills,
    'total_xp': totalXp,
  };
}
