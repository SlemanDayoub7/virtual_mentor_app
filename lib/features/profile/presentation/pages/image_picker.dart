import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';

class ProfileImagePicker extends StatefulWidget {
  final Function(File)? onImageSelected;
  final File? image;
  const ProfileImagePicker({super.key, this.onImageSelected, this.image});

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      widget.onImageSelected?.call(File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
      child: GestureDetector(
        // onTap: pickImage,
        child: CircleAvatar(
          foregroundColor: AppColors.primary,
          backgroundColor: AppColors.screenBackground,
          radius: 45.r,
          backgroundImage:
              widget.image != null ? FileImage(widget.image!) : null,
          child: widget.image == null ? Icon(Icons.person, size: 80.w) : null,
        ),
      ),
    );
  }
}
