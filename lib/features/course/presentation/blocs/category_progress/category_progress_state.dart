part of 'category_progress_bloc.dart';

abstract class CategoryProgressState extends Equatable {
  const CategoryProgressState();
  @override
  List<Object?> get props => [];
}

class CategoryProgressInitial extends CategoryProgressState {}

class CategoryProgressLoading extends CategoryProgressState {}

class CategoryProgressLoaded extends CategoryProgressState {
  final CategoryProgressEntity progress;
  const CategoryProgressLoaded(this.progress);
  @override
  List<Object?> get props => [progress];
}

class CategoryProgressFailure extends CategoryProgressState {
  final String message;
  const CategoryProgressFailure(this.message);
  @override
  List<Object?> get props => [message];
}
