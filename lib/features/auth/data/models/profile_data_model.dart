// lib/features/profile/data/models/profile_data_model.dart
import 'package:virtual_mentor_app/features/course/data/models/category_model.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/category_entity.dart';

import '../../domain/entities/profile_data.dart';

class ProfileDataModel extends ProfileData {
  ProfileDataModel({
    required int id,
    String? avatar,
    String? phone,
    String? address,
    String? birthDate,
    String? gender,
    CategoryEntity? currentCategory,
  }) : super(
         id: id,
         avatar: avatar,
         phone: phone,
         address: address,
         birthDate: birthDate,
         gender: gender,
         currentCategory: currentCategory,
       );

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) {
    return ProfileDataModel(
      id: json['id'] ?? 0,
      avatar: json['avatar'],
      phone: json['phone'],
      address: json['address'],
      birthDate: json['birth_date'],
      gender: json['gender'],
      currentCategory:
          json['current_category'] != null
              ? CategoryModel.fromJson(json['current_category'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'avatar': avatar,
      'phone': phone,
      'address': address,
      'birth_date': birthDate,
      'gender': gender,
      'current_category': (currentCategory as CategoryModel?)?.toJson(),
    };
  }
}
