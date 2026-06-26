import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';
import 'package:virtual_mentor_app/core/networking/api_result.dart';

class GoogleLoginUseCase {
  final AuthRepository _repository;
  const GoogleLoginUseCase(this._repository);

  Future<ApiResult<AuthEntity>> call({required String idToken}) =>
      _repository.googleLogin(idToken: idToken);
}
