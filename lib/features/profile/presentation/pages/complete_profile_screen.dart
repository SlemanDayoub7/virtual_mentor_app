import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/core/utils/app_assets.dart';
import 'package:virtual_mentor_app/features/profile/presentation/pages/basic_info%20.dart';
import 'package:virtual_mentor_app/features/profile/presentation/pages/personal_info.dart';
// ignore: prefer_const_constructors

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState
    extends State<CompleteProfileScreen> {

  final PageController pageController = PageController();
  File? selectedImage;
  int currentPage = 0;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final birthController = TextEditingController();

  bool imageDone = false;

String? gender;

double get progress {
  int completed = 0;

  if (imageDone) completed++;
  if (emailController.text.trim().isNotEmpty) completed++;
  if (phoneController.text.trim().isNotEmpty) completed++;
  if (addressController.text.trim().isNotEmpty) completed++;
  if (birthController.text.trim().isNotEmpty) completed++;
  if (gender != null) completed++;

  return completed / 6;
}
  @override
void initState() {
  super.initState();

  emailController.addListener(() {
    setState(() {});
  });

  phoneController.addListener(() {
    setState(() {});
  });

  addressController.addListener(() {
    setState(() {});
  });

  birthController.addListener(() {
    setState(() {});
  });
}
  Widget buildTab(
      String title,
      int index,
      ) {
    bool selected = currentPage == index;

    return InkWell(
      onTap: () {
        pageController.animateToPage(
          index,
          duration:
          const Duration(milliseconds: 300),
          curve: Curves.ease,
        );

        setState(() {
          currentPage = index;
        });
      },
      child: Container(
        padding:  EdgeInsets.symmetric(
          horizontal: 18.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : Colors.white,
          borderRadius:
          BorderRadius.circular(20.r)
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected
                ? Colors.white
                : AppColors.primary
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      body: Stack(
        children: [
          Positioned(
      top: 0,
      right: 0,
      child: SvgPicture.asset(
        AppAssets.backgroundShape,
        width: 57.w,
        height: 1.sh,
        fit: BoxFit.contain,
      ),
    ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 27.w,vertical:100.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              Row(
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 39.h,),
                  Text (context.tr.completeProfile,
                style: AppTextStyles.displayBold().copyWith(fontSize: 24.sp),
                ),
                ],
              ),
                SizedBox(height: 30.h,),
                LinearProgressIndicator(
                  color: AppColors.success,
                  backgroundColor:AppColors.grey200 ,
                  value: progress,
                  minHeight: 10.h,
                  borderRadius:
                  BorderRadius.circular(20.r)
                ),
                 SizedBox(height:16.h),
                Text(
                  "اكتمال الملف ${(progress * 100).toInt()}%",
                  style: AppTextStyles.bodyRegular(),
                ),
                 SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    buildTab(
                      context.tr.basicInfo,
                      0,
                    ),
                    SizedBox(width: 10.w),
                    buildTab(
                      context.tr.persoInfo,
                      1,
                    ),
                  ],
                ),
             SizedBox(height: 25.h),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    children: [
                       BasicInfoPage(
              emailController: emailController,
              imageDone: imageDone,
               selectedImage: selectedImage,
            onImageSelected: (file) {
              setState(() {
          selectedImage = file;
          imageDone = true;
              });
            },
              onNext: () {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
          
          setState(() {
            currentPage = 1;
          });
              },
            ),
            PersonalInfoPage(
              phoneController: phoneController,
              addressController: addressController,
              birthController: birthController,
              gender: gender,
              onGenderChanged: (value) {
          setState(() {
            gender = value;
          });
              },
            ),
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}