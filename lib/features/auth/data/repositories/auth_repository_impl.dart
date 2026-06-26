import 'dart:io';

import 'package:virtual_mentor_app/core/networking/api_result.dart';
import 'package:virtual_mentor_app/core/networking/safe_api_call.dart';
import 'package:virtual_mentor_app/features/auth/domain/entities/auth_entity.dart';
import 'package:virtual_mentor_app/features/auth/domain/entities/profile_entity.dart';
import 'package:virtual_mentor_app/features/auth/domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;
  const AuthRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<ProfileEntity>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) => safeApiCall(
    () => _dataSource.register(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    ),
  );

  @override
  Future<ApiResult<String>> verifyOtp({
    required String email,
    required String code,
  }) => safeApiCall(() => _dataSource.verifyOtp(email: email, code: code));

  @override
  Future<ApiResult<String>> resendOtp({required String email}) =>
      safeApiCall(() => _dataSource.resendOtp(email: email));

  @override
  Future<ApiResult<AuthEntity>> login({
    required String email,
    required String password,
  }) => safeApiCall(() => _dataSource.login(email: email, password: password));

  @override
  Future<ApiResult<AuthEntity>> googleLogin({required String idToken}) =>
      safeApiCall(() => _dataSource.googleLogin(idToken: idToken));

  @override
  Future<ApiResult<ProfileEntity>> getMe() =>
      safeApiCall(() => _dataSource.getMe());

  @override
  Future<ApiResult<ProfileEntity>> updateMe({
    String? firstName,
    String? lastName,
    String? phone,
    String? address,
    String? birthDate,
    String? gender,
    File? avatar,
    String? currentCategoryId,
  }) => safeApiCall(
    () => _dataSource.updateMe(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      address: address,
      birthDate: birthDate,
      gender: gender,
      avatar: avatar,
      currentCategoryId: currentCategoryId,
    ),
  );

  @override
  Future<ApiResult<void>> deleteMe({required String currentPassword}) =>
      safeApiCall(() => _dataSource.deleteMe(currentPassword: currentPassword));

  @override
  Future<ApiResult<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) => safeApiCall(
    () => _dataSource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    ),
  );

  @override
  Future<ApiResult<String>> forgotPassword({required String email}) =>
      safeApiCall(() => _dataSource.forgotPassword(email: email));

  @override
  Future<ApiResult<String>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) => safeApiCall(
    () => _dataSource.resetPassword(
      email: email,
      code: code,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    ),
  );
}
