import '../repositories/auth_repository.dart';
import 'package:virtual_mentor_app/core/networking/api_result.dart';

class ResendOtpUseCase {
  final AuthRepository _repository;
  const ResendOtpUseCase(this._repository);

  Future<ApiResult<String>> call({required String email}) =>
      _repository.resendOtp(email: email);
}
