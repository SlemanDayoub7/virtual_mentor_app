class ProgressOverviewEntity {
  final int totalCategories;
  final List<CategoryProgressStatesEntity> categories;

  const ProgressOverviewEntity({
    required this.totalCategories,
    required this.categories,
  });
}
class CategoryStatsEntity {
  final int totalSubjects;
  final int totalSkills;
  final int totalConcepts;
  final int masteredSkills;
  final int improvingSkills;
  final int weakSkills;
  final int notStartedSkills;
  final double progressPercentage;
  final double averageScore;
  final int totalXp;
  final DateTime? lastActivity;

  const CategoryStatsEntity({
    required this.totalSubjects,
    required this.totalSkills,
    required this.totalConcepts,
    required this.masteredSkills,
    required this.improvingSkills,
    required this.weakSkills,
    required this.notStartedSkills,
    required this.progressPercentage,
    required this.averageScore,
    required this.totalXp,
    this.lastActivity,
  });
}

class QuickSkillEntity {
  final String name;
  final double score;
  final String subject;

  const QuickSkillEntity({
    required this.name,
    required this.score,
    required this.subject,
  });
}

class CategoryQuickStatsEntity {
  final QuickSkillEntity? weakestSkill;
  final QuickSkillEntity? strongestSkill;
  final int nextAssessmentAvailable;

  const CategoryQuickStatsEntity({
    this.weakestSkill,
    this.strongestSkill,
    required this.nextAssessmentAvailable,
  });
}

class CategoryProgressStatesEntity {
  final int id;
  final String name;
  final String description;
  final String? icon;
  final CategoryStatsEntity stats;
  final CategoryQuickStatsEntity? quickStats;

  const CategoryProgressStatesEntity({
    required this.id,
    required this.name,
    required this.description,
    this.icon,
    required this.stats,
    this.quickStats,
  });

  bool get hasActivity => stats.lastActivity != null;
  bool get hasStarted => stats.totalSkills > 0;
}


