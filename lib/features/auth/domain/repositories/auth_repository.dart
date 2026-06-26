import 'dart:io';

import 'package:virtual_mentor_app/core/networking/api_result.dart';
import 'package:virtual_mentor_app/features/auth/domain/entities/profile_entity.dart';

import '../entities/auth_entity.dart';

abstract class AuthRepository {
  // Registration & activation
  Future<ApiResult<ProfileEntity>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });

  Future<ApiResult<String>> verifyOtp({
    required String email,
    required String code,
  });

  Future<ApiResult<String>> resendOtp({required String email});

  // Login
  Future<ApiResult<AuthEntity>> login({
    required String email,
    required String password,
  });

  Future<ApiResult<AuthEntity>> googleLogin({required String idToken});

  // Account
  Future<ApiResult<ProfileEntity>> getMe();

  Future<ApiResult<ProfileEntity>> updateMe({
    String? firstName,
    String? lastName,
    String? phone,
    String? address,
    String? birthDate,
    String? gender,
    File? avatar, // ← multipart upload
    String? currentCategoryId,
  });

  Future<ApiResult<void>> deleteMe({required String currentPassword});

  // Password
  Future<ApiResult<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<ApiResult<String>> forgotPassword({required String email});

  Future<ApiResult<String>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  });
}
