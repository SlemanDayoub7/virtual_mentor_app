import '../repositories/auth_repository.dart';
import 'package:virtual_mentor_app/core/networking/api_result.dart';

class VerifyOtpUseCase {
  final AuthRepository _repository;
  const VerifyOtpUseCase(this._repository);

  Future<ApiResult<String>> call({
    required String email,
    required String code,
  }) => _repository.verifyOtp(email: email, code: code);
}
