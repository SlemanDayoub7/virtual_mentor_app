import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/skill_profile_entity.dart';
import '../../../domain/usecases/get_skill_profiles_by_subject_usecase.dart';

part 'skill_profile_event.dart';
part 'skill_profile_state.dart';

class SkillProfileBloc extends Bloc<SkillProfileEvent, SkillProfileState> {
  final GetSkillProfilesBySubjectUseCase _getSkillProfilesBySubjectUseCase;

  SkillProfileBloc(this._getSkillProfilesBySubjectUseCase)
    : super(SkillProfileInitial()) {
    on<GetSkillProfilesBySubject>(_onGetSkillProfilesBySubject);
  }

  Future<void> _onGetSkillProfilesBySubject(
    GetSkillProfilesBySubject event,
    Emitter<SkillProfileState> emit,
  ) async {
    emit(SkillProfileLoading());
    final result = await _getSkillProfilesBySubjectUseCase(
      event.categoryId,
      event.subjectId,
    );
    result.when(
      success: (skillProfiles) => emit(SkillProfileLoaded(skillProfiles)),
      failure:
          (error) => emit(SkillProfileFailure(error.apiErrorModel.message)),
    );
  }
}
