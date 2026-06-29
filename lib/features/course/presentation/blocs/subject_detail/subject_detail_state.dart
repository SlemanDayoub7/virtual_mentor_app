part of 'subject_detail_bloc.dart';

abstract class SubjectDetailState extends Equatable {
  const SubjectDetailState();
  @override
  List<Object?> get props => [];
}

class SubjectDetailInitial extends SubjectDetailState {}

class SubjectDetailLoading extends SubjectDetailState {}

class SubjectDetailLoaded extends SubjectDetailState {
  final SubjectProgressEntity subject;
  final List<SkillProfileEntity> skillProfiles;
  final bool isLoadingProfiles;
  final String? error;

  const SubjectDetailLoaded({
    required this.subject,
    required this.skillProfiles,
    this.isLoadingProfiles = false,
    this.error,
  });

  @override
  List<Object?> get props => [subject, skillProfiles, isLoadingProfiles, error];
}

class SubjectDetailFailure extends SubjectDetailState {
  final String message;
  const SubjectDetailFailure(this.message);
  @override
  List<Object?> get props => [message];
}
