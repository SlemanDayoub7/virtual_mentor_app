// lib/domain/entities/category_progress_entity.dart

class CategoryProgressEntity {
  final SpecializationEntity specialization;
  final List<SubjectProgressEntity> subjects;
  final SummaryEntity summary;

  const CategoryProgressEntity({
    required this.specialization,
    required this.subjects,
    required this.summary,
  });
}

class SpecializationEntity {
  final int id;
  final String name;
  final String description;
  final String icon;
  final int totalSubjects;

  const SpecializationEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.totalSubjects,
  });
}

class SubjectProgressEntity {
  final int id;
  final String name;
  final String description;
  final StatsEntity stats;
  final QuickStatsEntity? quickStats;
  final RecentActivityEntity? recentActivity;
  final String status;

  const SubjectProgressEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.stats,
    this.quickStats,
    this.recentActivity,
    required this.status,
  });
}

class StatsEntity {
  final int totalSkills;
  final int totalConcepts;
  final int masteredSkills;
  final int improvingSkills;
  final int weakSkills;
  final int notStartedSkills;
  final double progressPercentage;
  final double averageScore;
  final int totalXp;
  final String? lastActivity;
  final int? daysSinceLastActivity;

  const StatsEntity({
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
    this.daysSinceLastActivity,
  });
}

class QuickStatsEntity {
  final SkillSummaryEntity? weakestSkill;
  final SkillSummaryEntity? strongestSkill;
  final SkillsByLevelEntity skillsByLevel;
  final int nextAssessmentAvailable;

  const QuickStatsEntity({
    this.weakestSkill,
    this.strongestSkill,
    required this.skillsByLevel,
    required this.nextAssessmentAvailable,
  });
}

class SkillSummaryEntity {
  final int id;
  final String name;
  final double score;
  final String level;

  const SkillSummaryEntity({
    required this.id,
    required this.name,
    required this.score,
    required this.level,
  });
}

class SkillsByLevelEntity {
  final int beginner;
  final int intermediate;
  final int advanced;

  const SkillsByLevelEntity({
    required this.beginner,
    required this.intermediate,
    required this.advanced,
  });
}

class RecentActivityEntity {
  final String lastSkillAssessed;
  final String? lastAssessmentDate;

  const RecentActivityEntity({
    required this.lastSkillAssessed,
    this.lastAssessmentDate,
  });
}

class SummaryEntity {
  final int totalSubjects;
  final int completedSubjects;
  final int inProgressSubjects;
  final int notStartedSubjects;
  final double overallProgress;
  final int totalSkills;
  final int masteredSkills;
  final int totalXp;

  const SummaryEntity({
    required this.totalSubjects,
    required this.completedSubjects,
    required this.inProgressSubjects,
    required this.notStartedSubjects,
    required this.overallProgress,
    required this.totalSkills,
    required this.masteredSkills,
    required this.totalXp,
  });
}
