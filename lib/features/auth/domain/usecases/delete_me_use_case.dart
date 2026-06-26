import 'package:virtual_mentor_app/core/networking/api_result.dart';
import 'package:virtual_mentor_app/features/auth/domain/repositories/auth_repository.dart';

class DeleteMeUseCase {
  final AuthRepository _repository;
  const DeleteMeUseCase(this._repository);

  Future<ApiResult<void>> call({required String currentPassword}) =>
      _repository.deleteMe(currentPassword: currentPassword);
}
