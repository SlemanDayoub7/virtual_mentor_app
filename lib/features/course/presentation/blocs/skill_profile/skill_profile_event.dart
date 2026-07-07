part of 'skill_profile_bloc.dart';

abstract class SkillProfileEvent extends Equatable {
  const SkillProfileEvent();
  @override
  List<Object?> get props => [];
}

class GetSkillProfilesBySubject extends SkillProfileEvent {
  final int categoryId;
  final int subjectId;

  const GetSkillProfilesBySubject({
    required this.categoryId,
    required this.subjectId,
  });

  @override
  List<Object?> get props => [categoryId, subjectId];
}
