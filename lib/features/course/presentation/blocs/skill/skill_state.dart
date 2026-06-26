part of 'skill_bloc.dart';

abstract class SkillState extends Equatable {
  const SkillState();
  @override
  List<Object?> get props => [];
}

class SkillInitial extends SkillState {}

class SkillLoading extends SkillState {}

class SkillLoaded extends SkillState {
  final List<SkillEntity> skills;
  const SkillLoaded(this.skills);
  @override
  List<Object?> get props => [skills];
}

class SkillFailure extends SkillState {
  final String message;
  const SkillFailure(this.message);
  @override
  List<Object?> get props => [message];
}
