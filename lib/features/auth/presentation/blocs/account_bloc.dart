import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:virtual_mentor_app/features/auth/domain/entities/profile_entity.dart';
import 'package:virtual_mentor_app/features/auth/domain/usecases/update_me_use_case.dart';

import '../../domain/usecases/get_me_usecase.dart';
import '../../domain/usecases/password_usecases.dart';

// ─── Events ───────────────────────────────────────────────────────────────────
abstract class AccountEvent extends Equatable {
  const AccountEvent();
  @override
  List<Object?> get props => [];
}

class AccountFetchRequested extends AccountEvent {}

class AccountUpdateSubmitted extends AccountEvent {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? address;
  final String? birthDate;
  final String? gender;

  const AccountUpdateSubmitted({
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.birthDate,
    this.gender,
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    phone,
    address,
    birthDate,
    gender,
  ];
}

class AccountDeleteRequested extends AccountEvent {
  final String currentPassword;
  const AccountDeleteRequested(this.currentPassword);
  @override
  List<Object?> get props => [currentPassword];
}

// ─── States ───────────────────────────────────────────────────────────────────
abstract class AccountState extends Equatable {
  const AccountState();
  @override
  List<Object?> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final ProfileEntity user;
  const AccountLoaded(this.user);
  @override
  List<Object?> get props => [user];
}

class AccountUpdateSuccess extends AccountState {
  final ProfileEntity user;
  const AccountUpdateSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class AccountDeleted extends AccountState {}

class AccountFailure extends AccountState {
  final String message;
  const AccountFailure(this.message);
  @override
  List<Object?> get props => [message];
}

// ─── Bloc ─────────────────────────────────────────────────────────────────────
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetMeUseCase _getMe;
  final UpdateMeUseCase _updateMe;
  final DeleteMeUseCase _deleteMe;

  AccountBloc(this._getMe, this._updateMe, this._deleteMe)
    : super(AccountInitial()) {
    on<AccountFetchRequested>(_onFetch);
    on<AccountUpdateSubmitted>(_onUpdate);
    on<AccountDeleteRequested>(_onDelete);
  }

  Future<void> _onFetch(
    AccountFetchRequested event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    final result = await _getMe();
    result.when(
      success: (user) => emit(AccountLoaded(user)),
      failure: (error) => emit(AccountFailure(error.apiErrorModel.message)),
    );
  }

  Future<void> _onUpdate(
    AccountUpdateSubmitted event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    final result = await _updateMe(
      firstName: event.firstName,
      lastName: event.lastName,
      phone: event.phone,
      address: event.address,
      birthDate: event.birthDate,
      gender: event.gender,
    );
    result.when(
      success: (user) => emit(AccountUpdateSuccess(user)),
      failure: (error) => emit(AccountFailure(error.apiErrorModel.message)),
    );
  }

  Future<void> _onDelete(
    AccountDeleteRequested event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    final result = await _deleteMe(currentPassword: event.currentPassword);
    result.when(
      success: (_) => emit(AccountDeleted()),
      failure: (error) => emit(AccountFailure(error.apiErrorModel.message)),
    );
  }
}
