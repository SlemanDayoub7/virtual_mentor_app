
import 'package:virtual_mentor_app/features/course/domain/entities/progress_overview_entity.dart';
class CategoryStatsModel extends CategoryStatsEntity {
  const CategoryStatsModel({
    required super.totalSubjects,
    required super.totalSkills,
    required super.totalConcepts,
    required super.masteredSkills,
    required super.improvingSkills,
    required super.weakSkills,
    required super.notStartedSkills,
    required super.progressPercentage,
    required super.averageScore,
    required super.totalXp,
    super.lastActivity,
  });

  factory CategoryStatsModel.fromJson(Map<String, dynamic> json) {
    return CategoryStatsModel(
      totalSubjects: json['total_subjects'] as int,
      totalSkills: json['total_skills'] as int,
      totalConcepts: json['total_concepts'] as int,
      masteredSkills: json['mastered_skills'] as int,
      improvingSkills: json['improving_skills'] as int,
      weakSkills: json['weak_skills'] as int,
      notStartedSkills: json['not_started_skills'] as int,
      progressPercentage: (json['progress_percentage'] as num).toDouble(),
      averageScore: (json['average_score'] as num).toDouble(),
      totalXp: json['total_xp'] as int,
      lastActivity: json['last_activity'] != null
          ? DateTime.parse(json['last_activity'] as String)
          : null,
    );
  }
}

class QuickSkillModel extends QuickSkillEntity {
  const QuickSkillModel({
    required super.name,
    required super.score,
    required super.subject,
  });

  factory QuickSkillModel.fromJson(Map<String, dynamic> json) {
    return QuickSkillModel(
      name: json['name'] as String,
      score: (json['score'] as num).toDouble(),
      subject: json['subject'] as String,
    );
  }
}

class CategoryQuickStatsModel extends CategoryQuickStatsEntity {
  const CategoryQuickStatsModel({
    super.weakestSkill,
    super.strongestSkill,
    required super.nextAssessmentAvailable,
  });

  factory CategoryQuickStatsModel.fromJson(Map<String, dynamic> json) {
    return CategoryQuickStatsModel(
      weakestSkill: json['weakest_skill'] != null
          ? QuickSkillModel.fromJson(
              json['weakest_skill'] as Map<String, dynamic>)
          : null,
      strongestSkill: json['strongest_skill'] != null
          ? QuickSkillModel.fromJson(
              json['strongest_skill'] as Map<String, dynamic>)
          : null,
      nextAssessmentAvailable: json['next_assessment_available'] as int,
    );
  }
}

class CategoryProgressStatesModel extends CategoryProgressStatesEntity {
  const CategoryProgressStatesModel({
    required super.id,
    required super.name,
    required super.description,
    super.icon,
    required CategoryStatsModel super.stats,
    CategoryQuickStatsModel? super.quickStats,
  });

  factory CategoryProgressStatesModel.fromJson(Map<String, dynamic> json) {
    return CategoryProgressStatesModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String?,
      stats: CategoryStatsModel.fromJson(
          json['stats'] as Map<String, dynamic>),
      quickStats: json['quick_stats'] != null
          ? CategoryQuickStatsModel.fromJson(
              json['quick_stats'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ProgressOverviewModel extends ProgressOverviewEntity {
  const ProgressOverviewModel({
    required super.totalCategories,
    required List<CategoryProgressStatesModel> super.categories,
  });

  factory ProgressOverviewModel.fromJson(Map<String, dynamic> json) {
    return ProgressOverviewModel(
      totalCategories: json['total_categories'] as int,
      categories: (json['categories'] as List<dynamic>)
          .map((e) =>
              CategoryProgressStatesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
