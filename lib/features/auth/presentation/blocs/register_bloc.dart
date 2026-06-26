import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:virtual_mentor_app/features/auth/domain/entities/profile_entity.dart';

import '../../domain/usecases/register_usecase.dart';

// ─── Events ───────────────────────────────────────────────────────────────────
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object?> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const RegisterSubmitted({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [email, password, firstName, lastName];
}

// ─── States ───────────────────────────────────────────────────────────────────
abstract class RegisterState extends Equatable {
  const RegisterState();
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final ProfileEntity user;
  const RegisterSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class RegisterFailure extends RegisterState {
  final String message;
  const RegisterFailure(this.message);
  @override
  List<Object?> get props => [message];
}

// ─── Bloc ─────────────────────────────────────────────────────────────────────
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterBloc(this._registerUseCase) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    final result = await _registerUseCase(
      email: event.email,
      password: event.password,
      firstName: event.firstName,
      lastName: event.lastName,
    );
    result.when(
      success: (user) => emit(RegisterSuccess(user)),
      failure: (error) => emit(RegisterFailure(error.apiErrorModel.message)),
    );
  }
}
