part of 'placement_bloc.dart';

abstract class PlacementEvent extends Equatable {
  const PlacementEvent();
  @override
  List<Object?> get props => [];
}

class StartPlacement extends PlacementEvent {
  final int categoryId;
  final int subjectId;
  final int skillId;

  const StartPlacement({
    required this.categoryId,
    required this.subjectId,
    required this.skillId,
  });

  @override
  List<Object?> get props => [categoryId, subjectId, skillId];
}

class SubmitPlacement extends PlacementEvent {
  final int placementId;
  final List<PlacementAnswerEntity> answers;

  const SubmitPlacement({required this.placementId, required this.answers});

  @override
  List<Object?> get props => [placementId, answers];
}
