import 'package:virtual_mentor_app/features/auth/domain/entities/profile_entity.dart';

import '../repositories/auth_repository.dart';
import 'package:virtual_mentor_app/core/networking/api_result.dart';

class RegisterUseCase {
  final AuthRepository _repository;
  const RegisterUseCase(this._repository);

  Future<ApiResult<ProfileEntity>> call({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) => _repository.register(
    email: email,
    password: password,
    firstName: firstName,
    lastName: lastName,
  );
}
