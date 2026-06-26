import 'package:virtual_mentor_app/core/networking/api_result.dart';
import 'package:virtual_mentor_app/features/auth/domain/entities/profile_entity.dart';

import '../repositories/auth_repository.dart';

class GetMeUseCase {
  final AuthRepository _repository;
  const GetMeUseCase(this._repository);

  Future<ApiResult<ProfileEntity>> call() => _repository.getMe();
}
