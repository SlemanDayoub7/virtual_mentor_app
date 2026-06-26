import '../repositories/auth_repository.dart';
import 'package:virtual_mentor_app/core/networking/api_result.dart';

class DeleteMeUseCase {
  final AuthRepository _repository;
  const DeleteMeUseCase(this._repository);

  Future<ApiResult<void>> call({required String currentPassword}) =>
      _repository.deleteMe(currentPassword: currentPassword);
}

class ChangePasswordUseCase {
  final AuthRepository _repository;
  const ChangePasswordUseCase(this._repository);

  Future<ApiResult<void>> call({
    required String currentPassword,
    required String newPassword,
  }) => _repository.changePassword(
    currentPassword: currentPassword,
    newPassword: newPassword,
  );
}

class ForgotPasswordUseCase {
  final AuthRepository _repository;
  const ForgotPasswordUseCase(this._repository);

  Future<ApiResult<String>> call({required String email}) =>
      _repository.forgotPassword(email: email);
}

class ResetPasswordUseCase {
  final AuthRepository _repository;
  const ResetPasswordUseCase(this._repository);

  Future<ApiResult<String>> call({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) => _repository.resetPassword(
    email: email,
    code: code,
    newPassword: newPassword,
    confirmPassword: confirmPassword,
  );
}
