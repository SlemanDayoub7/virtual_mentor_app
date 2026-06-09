import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/core/widgets/buttons/app_button.dart';
import 'package:virtual_mentor_app/core/widgets/text_fields/app_text_field.dart';
import 'package:virtual_mentor_app/features/profile/presentation/pages/image_picker.dart';

class BasicInfoPage extends StatelessWidget {
  final TextEditingController emailController;
  final bool imageDone;
  final VoidCallback onNext;
  final File? selectedImage;
  final Function(File) onImageSelected;
  const BasicInfoPage({
    super.key,
    required this.emailController,
    required this.imageDone,
    required this.onImageSelected,
    required this.onNext,
    required this.selectedImage,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.tr.imageProfile),

          ProfileImagePicker(
            //onImageSelected: onImageSelected,
               image: selectedImage,
              onImageSelected: onImageSelected,
          ),
          Center(
            child: Text(
              context.tr.editeProfile,
              style: AppTextStyles.captionRegular(
                color: AppColors.primary,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              top: 30.h,
              bottom: 75.h,
            ),
            child: AppTextField(
              controller: emailController,
              label: context.tr.email,
              hint: context.tr.enterEmailAddress,
              suffixIcon: Icons.email_outlined,
            ),
          ),

          AppButton(
            label: context.tr.next,
            onTap: onNext,
          ),
        ],
      ),
    );
  }
}