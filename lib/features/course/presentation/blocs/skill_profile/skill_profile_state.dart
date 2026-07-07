part of 'skill_profile_bloc.dart';

abstract class SkillProfileState extends Equatable {
  const SkillProfileState();
  @override
  List<Object?> get props => [];
}

class SkillProfileInitial extends SkillProfileState {}

class SkillProfileLoading extends SkillProfileState {}

class SkillProfileLoaded extends SkillProfileState {
  final List<SkillProfileEntity> skillProfiles;
  const SkillProfileLoaded(this.skillProfiles);
  @override
  List<Object?> get props => [skillProfiles];
}

class SkillProfileFailure extends SkillProfileState {
  final String message;
  const SkillProfileFailure(this.message);
  @override
  List<Object?> get props => [message];
}
