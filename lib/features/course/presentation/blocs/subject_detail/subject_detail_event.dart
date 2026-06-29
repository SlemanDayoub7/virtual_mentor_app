part of 'subject_detail_bloc.dart';

abstract class SubjectDetailEvent extends Equatable {
  const SubjectDetailEvent();
  @override
  List<Object?> get props => [];
}

class LoadSubjectDetail extends SubjectDetailEvent {
  final SubjectProgressEntity subject;
  const LoadSubjectDetail(this.subject);
  @override
  List<Object?> get props => [subject];
}
