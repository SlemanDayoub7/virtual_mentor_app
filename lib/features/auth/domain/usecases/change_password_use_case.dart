import 'package:virtual_mentor_app/core/networking/api_result.dart';
import 'package:virtual_mentor_app/features/auth/domain/repositories/auth_repository.dart';

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
