import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/usecases/get_categories_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase _getCategoriesUseCase;

  CategoryBloc(this._getCategoriesUseCase) : super(CategoryInitial()) {
    on<GetCategories>(_onGetCategories);
  }

  Future<void> _onGetCategories(
    GetCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final result = await _getCategoriesUseCase();
    result.when(
      success: (categories) => emit(CategoryLoaded(categories)),
      failure: (error) => emit(CategoryFailure(error.apiErrorModel.message)),
    );
  }
}
