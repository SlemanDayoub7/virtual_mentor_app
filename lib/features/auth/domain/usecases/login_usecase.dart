import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';
import 'package:virtual_mentor_app/core/networking/api_result.dart';

class LoginUseCase {
  final AuthRepository _repository;
  const LoginUseCase(this._repository);

  Future<ApiResult<AuthEntity>> call({
    required String email,
    required String password,
  }) => _repository.login(email: email, password: password);
}
