
import 'package:equatable/equatable.dart';

abstract class ProgressOverviewEvent extends Equatable {
  const ProgressOverviewEvent();
  @override
  List<Object?> get props => [];
}

class GetProgressOverview extends ProgressOverviewEvent {}