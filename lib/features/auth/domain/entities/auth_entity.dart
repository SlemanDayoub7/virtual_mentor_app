import 'package:virtual_mentor_app/features/auth/domain/entities/profile_entity.dart';

class AuthEntity {
  final String accessToken;
  final String refreshToken;
  final ProfileEntity? user;

  const AuthEntity({
    required this.accessToken,
    required this.refreshToken,
    this.user,
  });
}
