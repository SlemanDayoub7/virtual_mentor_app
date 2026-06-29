// lib/presentation/bloc/category_progress/category_progress_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/category_progress_entity.dart';
import '../../../domain/usecases/get_category_progress_usecase.dart';

part 'category_progress_event.dart';
part 'category_progress_state.dart';

class CategoryProgressBloc
    extends Bloc<CategoryProgressEvent, CategoryProgressState> {
  final GetCategoryProgressUseCase _getCategoryProgressUseCase;

  CategoryProgressBloc(this._getCategoryProgressUseCase)
    : super(CategoryProgressInitial()) {
    on<GetCategoryProgress>(_onGetCategoryProgress);
  }

  Future<void> _onGetCategoryProgress(
    GetCategoryProgress event,
    Emitter<CategoryProgressState> emit,
  ) async {
    emit(CategoryProgressLoading());
    final result = await _getCategoryProgressUseCase(event.categoryId);
    result.when(
      success: (progress) => emit(CategoryProgressLoaded(progress)),
      failure:
          (error) => emit(CategoryProgressFailure(error.apiErrorModel.message)),
    );
  }
}
