// lib/core/cubit/auth_state_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../storage/secure_storage_helper.dart';

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

// Cubit
class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AuthInitial());

  // Check authentication status on app start
  Future<void> checkAuthStatus() async {
    emit(AuthLoading());

    final hasTokens = await SecureStorageHelper.hasTokens();

    if (hasTokens) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  // Call after successful login
  void setAuthenticated() {
    emit(Authenticated());
  }

  // Call after logout
  void setUnauthenticated() {
    emit(Unauthenticated());
  }
}
