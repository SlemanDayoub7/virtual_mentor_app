import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/core/widgets/buttons/app_button.dart';
import 'package:virtual_mentor_app/core/widgets/text_fields/app_text_field.dart';
import 'package:virtual_mentor_app/features/profile/presentation/pages/date_picker_helper.dart';
import 'package:virtual_mentor_app/features/profile/presentation/pages/success_dialog.dart';

class PersonalInfoPage extends StatefulWidget {
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController birthController;

  final String? gender;
  final Function(String) onGenderChanged;

  const PersonalInfoPage({
    super.key,
    required this.phoneController,
    required this.addressController,
    required this.birthController,
    required this.gender,
    required this.onGenderChanged,
  });

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.tr.number),
          Container(
            decoration: BoxDecoration(
              color: AppColors.screenBackground,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: AppTextField(
                      controller: widget.phoneController,
                      hint: '999 999 999',
                      keyboardType: TextInputType.phone,
                      showBorder: false,
                    ),
                  ),
                ),
                Container(width: 1.w, height: 40.h, color: AppColors.grey200),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text('+963', style: AppTextStyles.labelRegular()),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          AppTextField(
            controller: widget.addressController,
            label: context.tr.address,
            hint: context.tr.address,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            prefixIcon: Icons.date_range_outlined,
            controller: widget.birthController,
            label: context.tr.date,
            hint: '00/00/000',
            readOnly: true,
            onTap: () {
              selectDate(context: context, controller: widget.birthController);
            },
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.onGenderChanged(context.tr.male);
                  },
                  child: Container(
                    height: 38.h,
                    width: 160.w,
                    decoration: BoxDecoration(
                      color:
                          widget.gender == context.tr.male
                              ? AppColors.primary
                              : AppColors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(
                      child: Text(
                        context.tr.male,
                        style: TextStyle(
                          color:
                              widget.gender == context.tr.male
                                  ? AppColors.white
                                  : AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.onGenderChanged(context.tr.famle);
                  },
                  child: Container(
                    height: 38.h,
                    width: 160.w,
                    decoration: BoxDecoration(
                      color:
                          widget.gender == context.tr.famle
                              ? AppColors.primary
                              : AppColors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(
                      child: Text(
                        context.tr.famle,
                        style: TextStyle(
                          color:
                              widget.gender == context.tr.famle
                                  ? AppColors.white
                                  : AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 75.h),
          AppButton(
            label: context.tr.save,
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const SuccessDialog(),
              );

              Future.delayed(const Duration(seconds: 2), () {
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
    );
  }
}
