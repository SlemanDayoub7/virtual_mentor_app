import 'package:virtual_mentor_app/features/course/data/models/progress_overview_model.dart';

class FakeCourseDataSource {
  const FakeCourseDataSource();

  Future<ProgressOverviewModel> getProgressOverview() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return const ProgressOverviewModel(
      totalCategories: 5,
      categories: [
        CategoryProgressStatesModel(
          id: 1,
          name: 'هندسة برمجيات',
          description: 'تعلم البرمجة من الأساسيات إلى المستويات المتقدمة بطريقة احترافية ومنظمة.',
          stats: CategoryStatsModel(
            totalSubjects: 7,
            totalSkills: 8,
            totalConcepts: 10,
            masteredSkills: 0,
            improvingSkills: 0,
            weakSkills: 1,
            notStartedSkills: 7,
            progressPercentage: 0.0,
            averageScore: 44.0,
            totalXp: 88,
          ),
          quickStats: CategoryQuickStatsModel(
            nextAssessmentAvailable: 1,
            weakestSkill: QuickSkillModel(
              name: 'FastAPI',
              score: 44.0,
              subject: 'Backend Development • تطوير الخدمات',
            ),
          ),
        ),
      ],
    );
  }
}