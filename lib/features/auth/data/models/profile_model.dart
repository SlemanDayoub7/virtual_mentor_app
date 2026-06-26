// lib/features/profile/data/models/profile_model.dart
import 'package:virtual_mentor_app/features/auth/data/models/profile_data_model.dart';

import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/profile_data.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    ProfileData? profile,
  }) : super(
         id: id,
         email: email,
         firstName: firstName,
         lastName: lastName,
         profile: profile,
       );

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      profile:
          json['profile'] != null
              ? ProfileDataModel.fromJson(json['profile'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'profile': (profile as ProfileDataModel?)?.toJson(),
    };
  }
}
