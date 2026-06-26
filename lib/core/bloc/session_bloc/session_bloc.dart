import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../storage/secure_storage_helper.dart';

// ─── Events ───────────────────────────────────────────────────────────────────
abstract class SessionEvent extends Equatable {
  const SessionEvent();
  @override
  List<Object?> get props => [];
}

/// Called once on app boot — checks storage for existing token
class SessionStarted extends SessionEvent {}

/// Called after successful login / register+activate
class SessionLoggedIn extends SessionEvent {}

/// Called when refresh token is expired (triggered from DioClient)
class SessionExpired extends SessionEvent {}

/// Called when user manually logs out
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
class SessionBloc extends Bloc<SessionEvent, SessionState>
    implements Listenable {
  SessionBloc() : super(SessionInitial()) {
    on<SessionStarted>(_onStarted);
    on<SessionLoggedIn>(_onLoggedIn);
    on<SessionExpired>(_onExpired);
    on<SessionLoggedOut>(_onLoggedOut);
  }

  final List<VoidCallback> _listeners = [];

  @override
  void addListener(VoidCallback listener) => _listeners.add(listener);

  @override
  void removeListener(VoidCallback listener) => _listeners.remove(listener);

  void _notify() {
    for (final cb in _listeners) {
      cb();
    }
  }

  @override
  void emit(SessionState state) {
    super.emit(state);
    _notify();
  }

  Future<void> _onStarted(
    SessionStarted event,
    Emitter<SessionState> emit,
  ) async {
    final hasTokens = await SecureStorageHelper.hasTokens();
    print('SessionBloc: SessionStarted - hasTokens: $hasTokens');
    emit(hasTokens ? SessionAuthenticated() : SessionUnauthenticated());
  }

  void _onLoggedIn(SessionLoggedIn event, Emitter<SessionState> emit) {
    emit(SessionAuthenticated());
  }

  void _onExpired(SessionExpired event, Emitter<SessionState> emit) {
    emit(SessionUnauthenticated());
  }

  Future<void> _onLoggedOut(
    SessionLoggedOut event,
    Emitter<SessionState> emit,
  ) async {
    await SecureStorageHelper.clearTokens();
    emit(SessionUnauthenticated());
  }
}
