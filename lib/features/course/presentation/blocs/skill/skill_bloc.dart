import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/skill_entity.dart';

import '../../../domain/usecases/get_skills_by_subject_usecase.dart';

part 'skill_event.dart';
part 'skill_state.dart';

class SkillBloc extends Bloc<SkillEvent, SkillState> {
  final GetSkillsBySubjectUseCase _getSkillsBySubjectUseCase;

  SkillBloc(this._getSkillsBySubjectUseCase) : super(SkillInitial()) {
    on<GetSkillsBySubject>(_onGetSkillsBySubject);
  }

  Future<void> _onGetSkillsBySubject(
    GetSkillsBySubject event,
    Emitter<SkillState> emit,
  ) async {
    emit(SkillLoading());

    final result = await _getSkillsBySubjectUseCase(
      event.categoryId,
      event.subjectId,
    );

    result.when(
      success: (skills) => emit(SkillLoaded(skills)),
      failure: (error) => emit(SkillFailure(error.apiErrorModel.message)),
    );
  }
}
