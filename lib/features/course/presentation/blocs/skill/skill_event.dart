part of 'skill_bloc.dart';

abstract class SkillEvent extends Equatable {
  const SkillEvent();
  @override
  List<Object?> get props => [];
}

class GetSkillsBySubject extends SkillEvent {
  final int categoryId;
  final int subjectId;
  const GetSkillsBySubject({required this.categoryId, required this.subjectId});
  @override
  List<Object?> get props => [subjectId, categoryId];
}
