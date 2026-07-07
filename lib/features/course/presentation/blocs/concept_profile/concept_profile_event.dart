part of 'concept_profile_bloc.dart';

abstract class ConceptProfileEvent extends Equatable {
  const ConceptProfileEvent();
  @override
  List<Object?> get props => [];
}

class GetConceptProfiles extends ConceptProfileEvent {
  final int categoryId;
  final int subjectId;
  final int skillId;

  const GetConceptProfiles({
    required this.categoryId,
    required this.subjectId,
    required this.skillId,
  });

  @override
  List<Object?> get props => [categoryId, subjectId, skillId];
}
