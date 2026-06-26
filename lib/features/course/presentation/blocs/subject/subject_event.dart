part of 'subject_bloc.dart';

abstract class SubjectEvent extends Equatable {
  const SubjectEvent();
  @override
  List<Object?> get props => [];
}

class GetSubjectsByCategory extends SubjectEvent {
  final int categoryId;
  const GetSubjectsByCategory(this.categoryId);
  @override
  List<Object?> get props => [categoryId];
}
