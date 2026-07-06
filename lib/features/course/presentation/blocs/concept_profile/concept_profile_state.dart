part of 'concept_profile_bloc.dart';

abstract class ConceptProfileState extends Equatable {
  const ConceptProfileState();
  @override
  List<Object?> get props => [];
}

class ConceptProfileInitial extends ConceptProfileState {}

class ConceptProfileLoading extends ConceptProfileState {}

class ConceptProfileLoaded extends ConceptProfileState {
  final List<ConceptProfileEntity> conceptProfiles;
  const ConceptProfileLoaded(this.conceptProfiles);
  @override
  List<Object?> get props => [conceptProfiles];
}

class ConceptProfileFailure extends ConceptProfileState {
  final String message;
  const ConceptProfileFailure(this.message);
  @override
  List<Object?> get props => [message];
}
