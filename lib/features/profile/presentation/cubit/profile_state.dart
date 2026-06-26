import 'package:equatable/equatable.dart';
import 'package:virtual_mentor_app/features/auth/domain/entities/profile_entity.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

// ── Load ─────────────────────────────────────────────────────────────────────
final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;
  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

final class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

// ── Update ────────────────────────────────────────────────────────────────────
final class ProfileUpdating extends ProfileState {
  const ProfileUpdating();
}

final class ProfileUpdateSuccess extends ProfileState {
  final ProfileEntity profile;
  const ProfileUpdateSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

final class ProfileUpdateError extends ProfileState {
  final String message;
  const ProfileUpdateError(this.message);

  @override
  List<Object?> get props => [message];
}

// ── Delete ────────────────────────────────────────────────────────────────────
final class ProfileDeleting extends ProfileState {
  const ProfileDeleting();
}

final class ProfileDeleteSuccess extends ProfileState {
  const ProfileDeleteSuccess();
}

final class ProfileDeleteError extends ProfileState {
  final String message;
  const ProfileDeleteError(this.message);

  @override
  List<Object?> get props => [message];
}

// ── Change password ───────────────────────────────────────────────────────────
final class ProfilePasswordChanging extends ProfileState {
  const ProfilePasswordChanging();
}

final class ProfilePasswordChangeSuccess extends ProfileState {
  const ProfilePasswordChangeSuccess();
}

final class ProfilePasswordChangeError extends ProfileState {
  final String message;
  const ProfilePasswordChangeError(this.message);

  @override
  List<Object?> get props => [message];
}
