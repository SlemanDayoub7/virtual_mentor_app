import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/subject_entity.dart';
import '../../../domain/usecases/get_subjects_by_category_usecase.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final GetSubjectsByCategoryUseCase _getSubjectsByCategoryUseCase;

  SubjectBloc(this._getSubjectsByCategoryUseCase) : super(SubjectInitial()) {
    on<GetSubjectsByCategory>(_onGetSubjectsByCategory);
  }

  Future<void> _onGetSubjectsByCategory(
    GetSubjectsByCategory event,
    Emitter<SubjectState> emit,
  ) async {
    emit(SubjectLoading());
    final result = await _getSubjectsByCategoryUseCase(event.categoryId);
    result.when(
      success: (subjects) => emit(SubjectLoaded(subjects)),
      failure: (error) => emit(SubjectFailure(error.apiErrorModel.message)),
    );
  }
}
