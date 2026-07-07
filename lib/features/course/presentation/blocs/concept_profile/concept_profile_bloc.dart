import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/concept_profile_entity.dart';
import '../../../domain/usecases/get_concept_profiles_usecase.dart';

part 'concept_profile_event.dart';
part 'concept_profile_state.dart';

class ConceptProfileBloc
    extends Bloc<ConceptProfileEvent, ConceptProfileState> {
  final GetConceptProfilesUseCase _getConceptProfilesUseCase;

  ConceptProfileBloc(this._getConceptProfilesUseCase)
    : super(ConceptProfileInitial()) {
    on<GetConceptProfiles>(_onGetConceptProfiles);
  }

  Future<void> _onGetConceptProfiles(
    GetConceptProfiles event,
    Emitter<ConceptProfileState> emit,
  ) async {
    emit(ConceptProfileLoading());
    final result = await _getConceptProfilesUseCase(
      event.categoryId,
      event.subjectId,
      event.skillId,
    );
    result.when(
      success: (conceptProfiles) => emit(ConceptProfileLoaded(conceptProfiles)),
      failure:
          (error) => emit(ConceptProfileFailure(error.apiErrorModel.message)),
    );
  }
}
