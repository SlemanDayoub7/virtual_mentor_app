part of 'category_progress_bloc.dart';

abstract class CategoryProgressEvent extends Equatable {
  const CategoryProgressEvent();
  @override
  List<Object?> get props => [];
}

class GetCategoryProgress extends CategoryProgressEvent {
  final int categoryId;
  const GetCategoryProgress(this.categoryId);
  @override
  List<Object?> get props => [categoryId];
}
