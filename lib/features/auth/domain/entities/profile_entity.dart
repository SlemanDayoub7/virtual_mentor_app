import 'package:virtual_mentor_app/features/auth/domain/entities/profile_data.dart';

class ProfileEntity {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final ProfileData? profile;

  ProfileEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profile,
  });

  String get fullName => '$firstName $lastName';

  bool get hasProfile => profile != null;

  bool get hasSpecialization => profile?.currentCategory != null;

  ProfileEntity copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    ProfileData? profile,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profile: profile ?? this.profile,
    );
  }
}
