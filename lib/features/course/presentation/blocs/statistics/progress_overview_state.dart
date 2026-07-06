
import 'package:equatable/equatable.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/progress_overview_entity.dart';

abstract class ProgressOverviewState extends Equatable {
  const ProgressOverviewState();
  @override
  List<Object?> get props => [];
}

class ProgressOverviewInitial extends ProgressOverviewState {}

class ProgressOverviewLoading extends ProgressOverviewState {}

class ProgressOverviewLoaded extends ProgressOverviewState {
  final ProgressOverviewEntity statistics;
  const ProgressOverviewLoaded(this.statistics);
  @override
  List<Object?> get props => [statistics];
}

class ProgressOverviewFailure extends ProgressOverviewState {
  final String message;
  const ProgressOverviewFailure(this.message);
  @override
  List<Object?> get props => [message];
}
