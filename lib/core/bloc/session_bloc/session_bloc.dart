import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// ─── Events ───────────────────────────────────────────────────────────────────
abstract class SessionEvent extends Equatable {
  const SessionEvent();
  @override
  List<Object?> get props => [];
}

class SessionStarted extends SessionEvent {}
class SessionExpired extends SessionEvent {}
class SessionLoggedOut extends SessionEvent {}

// ─── States ───────────────────────────────────────────────────────────────────
abstract class SessionState extends Equatable {
  const SessionState();
  @override
  List<Object?> get props => [];
}

class SessionInitial extends SessionState {}
class SessionAuthenticated extends SessionState {}
class SessionUnauthenticated extends SessionState {}

// ─── Bloc ─────────────────────────────────────────────────────────────────────
class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc() : super(SessionInitial()) {
    on<SessionStarted>(_onStarted);
    on<SessionExpired>(_onExpired);
    on<SessionLoggedOut>(_onLoggedOut);
  }

  void _onStarted(SessionStarted event, Emitter<SessionState> emit) {
    emit(SessionAuthenticated());
  }

  void _onExpired(SessionExpired event, Emitter<SessionState> emit) {
    emit(SessionUnauthenticated());
  }

  void _onLoggedOut(SessionLoggedOut event, Emitter<SessionState> emit) {
    emit(SessionUnauthenticated());
  }
}
