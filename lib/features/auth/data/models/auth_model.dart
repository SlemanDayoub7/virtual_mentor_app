import '../../domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({required super.accessToken, required super.refreshToken});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    accessToken: json['access'] as String,
    refreshToken: json['refresh'] as String,
  );
}
