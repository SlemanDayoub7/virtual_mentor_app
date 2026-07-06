
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_mentor_app/features/course/domain/usecases/get_progress_overview_usecase.dart';
import 'package:virtual_mentor_app/features/course/presentation/blocs/statistics/progress_overview_event.dart';
import 'package:virtual_mentor_app/features/course/presentation/blocs/statistics/progress_overview_state.dart';

class ProgressOverviewBloc extends Bloc<ProgressOverviewEvent, ProgressOverviewState> {
  final GetProgressOverviewUseCase _getProgressOverviewUseCase;

  ProgressOverviewBloc(this._getProgressOverviewUseCase) : super(ProgressOverviewInitial()) {
    on<GetProgressOverview>(_onGetProgressOverview);
  }

  Future<void> _onGetProgressOverview(
    GetProgressOverview event,
    Emitter<ProgressOverviewState> emit,
  ) async {
    emit(ProgressOverviewLoading());
    final result = await _getProgressOverviewUseCase();
    result.when(
      success: (statistics) => emit(ProgressOverviewLoaded(statistics)),
      failure: (error) => emit(ProgressOverviewFailure(error.apiErrorModel.message)),
    );
  }
}