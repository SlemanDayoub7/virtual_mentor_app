part of 'placement_bloc.dart';

abstract class PlacementState extends Equatable {
  const PlacementState();
  @override
  List<Object?> get props => [];
}

class PlacementInitial extends PlacementState {}

class PlacementLoading extends PlacementState {}

class PlacementSessionLoaded extends PlacementState {
  final PlacementSessionEntity session;
  const PlacementSessionLoaded(this.session);
  @override
  List<Object?> get props => [session];
}

class PlacementSubmitting extends PlacementState {}

class PlacementResultLoaded extends PlacementState {
  final PlacementResultEntity result;
  const PlacementResultLoaded(this.result);
  @override
  List<Object?> get props => [result];
}

class PlacementFailure extends PlacementState {
  final String message;
  const PlacementFailure(this.message);
  @override
  List<Object?> get props => [message];
}
