import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_mentor_app/features/auth/domain/usecases/get_me_usecase.dart';
import 'package:virtual_mentor_app/features/auth/domain/usecases/password_usecases.dart';
import 'package:virtual_mentor_app/features/auth/domain/usecases/update_me_use_case.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetMeUseCase _getMe;
  final UpdateMeUseCase _updateMe;
  final DeleteMeUseCase _deleteMe;
  final ChangePasswordUseCase _changePassword;

  ProfileCubit({
    required GetMeUseCase getMe,
    required UpdateMeUseCase updateMe,
    required DeleteMeUseCase deleteMe,
    required ChangePasswordUseCase changePassword,
  }) : _getMe = getMe,
       _updateMe = updateMe,
       _deleteMe = deleteMe,
       _changePassword = changePassword,
       super(const ProfileLoading());

  // ── Load ────────────────────────────────────────────────────────────────────
  Future<void> loadProfile() async {
    emit(const ProfileLoading());
    final result = await _getMe();
    result.when(
      success: (profile) => emit(ProfileLoaded(profile)),
      failure: (e) => emit(ProfileError(e.toString())),
    );
  }

  // ── Update ──────────────────────────────────────────────────────────────────
  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? phone,
    String? address,
    String? birthDate,
    String? gender,
    File? avatar,
    String? currentCategoryId,
  }) async {
    emit(const ProfileUpdating());
    final result = await _updateMe(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      address: address,
      birthDate: birthDate,
      gender: gender,
      avatar: avatar,
      currentCategoryId: currentCategoryId,
    );
    result.when(
      success: (profile) => emit(ProfileUpdateSuccess(profile)),
      failure: (e) => emit(ProfileUpdateError(e.toString())),
    );
  }

  // ── Delete account ──────────────────────────────────────────────────────────
  Future<void> deleteAccount({required String currentPassword}) async {
    emit(const ProfileDeleting());
    final result = await _deleteMe(currentPassword: currentPassword);
    result.when(
      success: (_) => emit(const ProfileDeleteSuccess()),
      failure: (e) => emit(ProfileDeleteError(e.toString())),
    );
  }

  // ── Change password ─────────────────────────────────────────────────────────
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(const ProfilePasswordChanging());
    final result = await _changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    result.when(
      success: (_) => emit(const ProfilePasswordChangeSuccess()),
      failure: (e) => emit(ProfilePasswordChangeError(e.toString())),
    );
  }
}
