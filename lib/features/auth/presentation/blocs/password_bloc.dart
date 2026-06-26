import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/password_usecases.dart';

// ─── Events ───────────────────────────────────────────────────────────────────
abstract class PasswordEvent extends Equatable {
  const PasswordEvent();
  @override
  List<Object?> get props => [];
}

class ChangePasswordSubmitted extends PasswordEvent {
  final String currentPassword;
  final String newPassword;
  const ChangePasswordSubmitted({
    required this.currentPassword,
    required this.newPassword,
  });
  @override
  List<Object?> get props => [currentPassword, newPassword];
}

class ForgotPasswordSubmitted extends PasswordEvent {
  final String email;
  const ForgotPasswordSubmitted(this.email);
  @override
  List<Object?> get props => [email];
}

class ResetPasswordSubmitted extends PasswordEvent {
  final String email;
  final String code;
  final String newPassword;
  final String confirmPassword;
  const ResetPasswordSubmitted({
    required this.email,
    required this.code,
    required this.newPassword,
    required this.confirmPassword,
  });
  @override
  List<Object?> get props => [email, code, newPassword, confirmPassword];
}

// ─── States ───────────────────────────────────────────────────────────────────
abstract class PasswordState extends Equatable {
  const PasswordState();
  @override
  List<Object?> get props => [];
}

class PasswordInitial extends PasswordState {}

class PasswordLoading extends PasswordState {}

class PasswordSuccess extends PasswordState {
  final String message;
  const PasswordSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class PasswordFailure extends PasswordState {
  final String message;
  const PasswordFailure(this.message);
  @override
  List<Object?> get props => [message];
}

// ─── Bloc ─────────────────────────────────────────────────────────────────────
class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final ChangePasswordUseCase _changePassword;
  final ForgotPasswordUseCase _forgotPassword;
  final ResetPasswordUseCase _resetPassword;

  PasswordBloc(this._changePassword, this._forgotPassword, this._resetPassword)
    : super(PasswordInitial()) {
    on<ChangePasswordSubmitted>(_onChange);
    on<ForgotPasswordSubmitted>(_onForgot);
    on<ResetPasswordSubmitted>(_onReset);
  }

  Future<void> _onChange(
    ChangePasswordSubmitted event,
    Emitter<PasswordState> emit,
  ) async {
    emit(PasswordLoading());
    final result = await _changePassword(
      currentPassword: event.currentPassword,
      newPassword: event.newPassword,
    );
    result.when(
      success:
          (_) => emit(const PasswordSuccess('Password changed successfully')),
      failure: (error) => emit(PasswordFailure(error.apiErrorModel.message)),
    );
  }

  Future<void> _onForgot(
    ForgotPasswordSubmitted event,
    Emitter<PasswordState> emit,
  ) async {
    emit(PasswordLoading());
    final result = await _forgotPassword(email: event.email);
    result.when(
      success: (msg) => emit(PasswordSuccess(msg)),
      failure: (error) => emit(PasswordFailure(error.apiErrorModel.message)),
    );
  }

  Future<void> _onReset(
    ResetPasswordSubmitted event,
    Emitter<PasswordState> emit,
  ) async {
    emit(PasswordLoading());
    final result = await _resetPassword(
      email: event.email,
      code: event.code,
      newPassword: event.newPassword,
      confirmPassword: event.confirmPassword,
    );
    result.when(
      success: (msg) => emit(PasswordSuccess(msg)),
      failure: (error) => emit(PasswordFailure(error.apiErrorModel.message)),
    );
  }
}
