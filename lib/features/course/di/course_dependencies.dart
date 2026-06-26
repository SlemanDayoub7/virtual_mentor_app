import 'package:get_it/get_it.dart';
import 'package:virtual_mentor_app/features/course/data/datasources/course_remote_datasource.dart';
import 'package:virtual_mentor_app/features/course/data/repositories/course_repository_impl.dart';
import 'package:virtual_mentor_app/features/course/domain/repositories/course_repository.dart';
import 'package:virtual_mentor_app/features/course/domain/usecases/get_categories_usecase.dart';
import 'package:virtual_mentor_app/features/course/domain/usecases/get_subjects_by_category_usecase.dart';
import 'package:virtual_mentor_app/features/course/domain/usecases/get_skills_by_subject_usecase.dart';
import 'package:virtual_mentor_app/features/course/presentation/blocs/category/category_bloc.dart';
import 'package:virtual_mentor_app/features/course/presentation/blocs/subject/subject_bloc.dart';
import 'package:virtual_mentor_app/features/course/presentation/blocs/skill/skill_bloc.dart';

void registerCourseDependencies(GetIt sl) {
  // ── Data source ───────────────────────────────────────────────────────────
  sl.registerLazySingleton<CourseRemoteDataSource>(
    () => CourseRemoteDataSourceImpl(sl()),
  );

  // ── Repository ────────────────────────────────────────────────────────────
  sl.registerLazySingleton<CourseRepository>(() => CourseRepositoryImpl(sl()));

  // ── Use cases ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetSubjectsByCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetSkillsBySubjectUseCase(sl()));

  // ── Blocs (factory — new instance per screen) ─────────────────────────────
  sl.registerFactory(() => CategoryBloc(sl()));
  sl.registerFactory(() => SubjectBloc(sl()));
  sl.registerFactory(() => SkillBloc(sl()));
}
