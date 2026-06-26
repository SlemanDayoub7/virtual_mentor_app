import 'dart:io';

import 'package:virtual_mentor_app/core/networking/api_result.dart';
import 'package:virtual_mentor_app/features/auth/domain/entities/profile_entity.dart';
import 'package:virtual_mentor_app/features/auth/domain/repositories/auth_repository.dart';

class UpdateMeUseCase {
  final AuthRepository _repository;
  const UpdateMeUseCase(this._repository);

  Future<ApiResult<ProfileEntity>> call({
    String? firstName,
    String? lastName,
    String? phone,
    String? address,
    String? birthDate,
    String? gender,
    File? avatar,
    String? currentCategoryId,
  }) => _repository.updateMe(
    firstName: firstName,
    lastName: lastName,
    phone: phone,
    address: address,
    birthDate: birthDate,
    gender: gender,
    avatar: avatar,
    currentCategoryId: currentCategoryId,
  );
}
