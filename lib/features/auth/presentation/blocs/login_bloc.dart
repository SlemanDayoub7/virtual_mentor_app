import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/google_login_usecase.dart';

// ─── Events ───────────────────────────────────────────────────────────────────
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;
  const LoginSubmitted({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class GoogleLoginPressed extends LoginEvent {
  final String idToken;
  const GoogleLoginPressed(this.idToken);
  @override
  List<Object?> get props => [idToken];
}

// ─── States ───────────────────────────────────────────────────────────────────
abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final AuthEntity auth;
  const LoginSuccess(this.auth);
  @override
  List<Object?> get props => [auth];
}

class LoginFailure extends LoginState {
  final String message;
  const LoginFailure(this.message);
  @override
  List<Object?> get props => [message];
}

// ─── Bloc ─────────────────────────────────────────────────────────────────────
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _login;
  final GoogleLoginUseCase _googleLogin;

  LoginBloc(this._login, this._googleLogin) : super(LoginInitial()) {
    on<LoginSubmitted>(_onSubmitted);
    on<GoogleLoginPressed>(_onGooglePressed);
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final result = await _login(email: event.email, password: event.password);
    result.when(
      success: (auth) => emit(LoginSuccess(auth)),
      failure: (error) => emit(LoginFailure(error.apiErrorModel.message)),
    );
  }

  Future<void> _onGooglePressed(
    GoogleLoginPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final result = await _googleLogin(idToken: event.idToken);
    result.when(
      success: (auth) => emit(LoginSuccess(auth)),
      failure: (error) => emit(LoginFailure(error.apiErrorModel.message)),
    );
  }
}
