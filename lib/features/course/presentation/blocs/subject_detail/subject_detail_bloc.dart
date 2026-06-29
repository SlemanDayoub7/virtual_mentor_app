// lib/features/course/presentation/blocs/subject_detail/subject_detail_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/category_progress_entity.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/skill_profile_entity.dart';
import 'package:virtual_mentor_app/features/course/domain/usecases/get_skill_profiles_usecase.dart';

part 'subject_detail_event.dart';
part 'subject_detail_state.dart';

class SubjectDetailBloc extends Bloc<SubjectDetailEvent, SubjectDetailState> {
  final GetSkillProfilesUseCase _getSkillProfilesUseCase;

  SubjectDetailBloc(this._getSkillProfilesUseCase)
    : super(SubjectDetailInitial()) {
    on<LoadSubjectDetail>(_onLoadSubjectDetail);
  }

  Future<void> _onLoadSubjectDetail(
    LoadSubjectDetail event,
    Emitter<SubjectDetailState> emit,
  ) async {
    emit(SubjectDetailLoading());

    // First emit the subject data
    emit(
      SubjectDetailLoaded(
        subject: event.subject,
        skillProfiles: [],
        isLoadingProfiles: true,
      ),
    );

    // ✅ Fetch skill profiles filtered by subject ID
    final result = await _getSkillProfilesUseCase(
      //subjectId: event.subject.id, // Pass subject ID to filter
    );

    result.when(
      success: (profiles) {
        emit(
          SubjectDetailLoaded(
            subject: event.subject,
            skillProfiles: profiles, // Already filtered by backend
            isLoadingProfiles: false,
          ),
        );
      },
      failure: (error) {
        emit(
          SubjectDetailLoaded(
            subject: event.subject,
            skillProfiles: [],
            isLoadingProfiles: false,
            error: error.apiErrorModel.message,
          ),
        );
      },
    );
  }
}
