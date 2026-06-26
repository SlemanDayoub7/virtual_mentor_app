import 'package:virtual_mentor_app/features/course/domain/entities/category_entity.dart';

class ProfileData {
  final int id;
  final String? avatar;
  final String? phone;
  final String? address;
  final String? birthDate;
  final String? gender;
  final CategoryEntity? currentCategory;

  ProfileData({
    required this.id,
    this.avatar,
    this.phone,
    this.address,
    this.birthDate,
    this.gender,
    this.currentCategory,
  });

  bool get hasCompleteProfile {
    return phone != null &&
        phone!.isNotEmpty &&
        address != null &&
        address!.isNotEmpty;
  }

  ProfileData copyWith({
    int? id,
    String? avatar,
    String? phone,
    String? address,
    String? birthDate,
    String? gender,
    CategoryEntity? currentCategory,
  }) {
    return ProfileData(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      currentCategory: currentCategory ?? this.currentCategory,
    );
  }
}
