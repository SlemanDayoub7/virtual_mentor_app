import 'dart:io';

import 'package:dio/dio.dart';
import 'package:virtual_mentor_app/core/networking/dio_client.dart';
import 'package:virtual_mentor_app/features/auth/data/models/auth_model.dart';
import 'package:virtual_mentor_app/features/auth/data/models/profile_data_model.dart';
import 'package:virtual_mentor_app/features/auth/data/models/profile_model.dart';
import 'package:virtual_mentor_app/features/course/data/models/category_model.dart';

abstract class AuthRemoteDataSource {
  Future<ProfileModel> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });

  Future<String> verifyOtp({required String email, required String code});
  Future<String> resendOtp({required String email});

  Future<AuthModel> login({required String email, required String password});
  Future<AuthModel> googleLogin({required String idToken});

  Future<ProfileModel> getMe();

  Future<ProfileModel> updateMe({
    String? firstName,
    String? lastName,
    String? phone,
    String? address,
    String? birthDate,
    String? gender,
    File? avatar,
    String? currentCategoryId,
  });

  Future<void> deleteMe({required String currentPassword});

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<String> forgotPassword({required String email});

  Future<String> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _client;
  const AuthRemoteDataSourceImpl(this._client);

  @override
  Future<ProfileModel> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final response = await _client.dio.post(
      '/auth/users/',
      data: {
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
      },
    );
    return ProfileModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<String> verifyOtp({
    required String email,
    required String code,
  }) async {
    final response = await _client.dio.post(
      '/api/verify-otp/',
      data: {'email': email, 'code': code},
    );
    return response.data['detail'] as String;
  }

  @override
  Future<String> resendOtp({required String email}) async {
    final response = await _client.dio.post(
      '/api/resend-otp/',
      data: {'email': email},
    );
    return response.data['detail'] as String;
  }

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.dio.post(
      '/auth/jwt/create',
      data: {'email': email, 'password': password},
    );
    return AuthModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<AuthModel> googleLogin({required String idToken}) async {
    final response = await _client.dio.post(
      '/api/auth/google/',
      data: {'id_token': idToken},
    );
    return AuthModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<ProfileModel> getMe() async {
    // await Future.delayed(const Duration(milliseconds: 500));

    // // Return fake profile data
    // return ProfileModel(
    //   id: 1,
    //   email: 'john.doe@example.com',
    //   firstName: 'John',
    //   lastName: 'Doe',
    //   profile: ProfileDataModel(
    //     id: 1,
    //     // avatar: 'https://i.pravatar.cc/150?img=1',
    //     // phone: '+1234567890',
    //     // address: '123 Main Street, New York, NY 10001',
    //     // birthDate: '1990-01-15',
    //     // gender: 'm',
    //     // currentCategory: const CategoryModel(
    //     //   id: 1,
    //     //   name: 'Technology',
    //     //   description: 'Learn about technology and programming',
    //     //   icon: '💻',
    //     // ),
    //   ),
    // );
    final response = await _client.dio.get('/auth/users/me/');
    return ProfileModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<ProfileModel> updateMe({
    String? firstName,
    String? lastName,
    String? phone,
    String? address,
    String? birthDate,
    String? gender,
    File? avatar,
    String? currentCategoryId,
  }) async {
    // Use multipart only when there is an image; plain PATCH otherwise.
    if (avatar != null) {
      final formData = FormData.fromMap({
        if (firstName != null) 'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
        // Profile fields including avatar should be nested under 'profile'
        'profile': {
          'avatar': await MultipartFile.fromFile(
            avatar.path,
            filename: avatar.path.split('/').last,
          ),
          if (phone != null) 'phone': phone,
          if (address != null) 'address': address,
          if (birthDate != null) 'birth_date': birthDate,
          if (gender != null) 'gender': gender,
          if (currentCategoryId != null)
            'current_category_id': currentCategoryId,
        },
      });

      final response = await _client.dio.patch(
        '/auth/users/me/',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      return ProfileModel.fromJson(response.data as Map<String, dynamic>);
    }

    // No image — plain JSON PATCH
    final body = <String, dynamic>{
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      // Profile fields should be nested under 'profile'
      'profile': {
        if (phone != null) 'phone': phone,
        if (address != null) 'address': address,
        if (birthDate != null) 'birth_date': birthDate,
        if (gender != null) 'gender': gender,
        if (currentCategoryId != null) 'current_category_id': currentCategoryId,
      },
    };

    final response = await _client.dio.patch('/auth/users/me/', data: body);
    return ProfileModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> deleteMe({required String currentPassword}) async {
    await _client.dio.delete(
      '/auth/users/me/',
      data: {'current_password': currentPassword},
    );
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _client.dio.post(
      '/auth/users/set_password/',
      data: {'current_password': currentPassword, 'new_password': newPassword},
    );
  }

  @override
  Future<String> forgotPassword({required String email}) async {
    final response = await _client.dio.post(
      '/api/forgot-password/',
      data: {'email': email},
    );
    return response.data['detail'] as String;
  }

  @override
  Future<String> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final response = await _client.dio.post(
      '/api/reset-password/',
      data: {
        'email': email,
        'code': code,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      },
    );
    return response.data['detail'] as String;
  }
}
