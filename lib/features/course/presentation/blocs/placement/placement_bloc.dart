import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/placement_answer_entity.dart';
import '../../../domain/entities/placement_result_entity.dart';
import '../../../domain/entities/placement_session_entity.dart';
import '../../../domain/usecases/start_placement_usecase.dart';
import '../../../domain/usecases/submit_placement_usecase.dart';

part 'placement_event.dart';
part 'placement_state.dart';

class PlacementBloc extends Bloc<PlacementEvent, PlacementState> {
  final StartPlacementUseCase _startPlacementUseCase;
  final SubmitPlacementUseCase _submitPlacementUseCase;

  PlacementBloc(this._startPlacementUseCase, this._submitPlacementUseCase)
    : super(PlacementInitial()) {
    on<StartPlacement>(_onStartPlacement);
    on<SubmitPlacement>(_onSubmitPlacement);
  }

  Future<void> _onStartPlacement(
    StartPlacement event,
    Emitter<PlacementState> emit,
  ) async {
    emit(PlacementLoading());
    final result = await _startPlacementUseCase(
      event.categoryId,
      event.subjectId,
      event.skillId,
    );
    result.when(
      success: (session) => emit(PlacementSessionLoaded(session)),
      failure: (error) => emit(PlacementFailure(error.apiErrorModel.message)),
    );
  }

  Future<void> _onSubmitPlacement(
    SubmitPlacement event,
    Emitter<PlacementState> emit,
  ) async {
    emit(PlacementSubmitting());
    final result = await _submitPlacementUseCase(
      event.placementId,
      event.answers,
    );
    result.when(
      success:
          (placementResult) => emit(PlacementResultLoaded(placementResult)),
      failure: (error) => emit(PlacementFailure(error.apiErrorModel.message)),
    );
  }
}
