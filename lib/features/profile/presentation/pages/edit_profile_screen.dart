import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/core/widgets/buttons/app_button.dart';
import 'package:virtual_mentor_app/core/widgets/text_fields/app_text_field.dart';
import 'package:virtual_mentor_app/features/auth/domain/entities/profile_entity.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_state.dart';
import 'package:virtual_mentor_app/features/profile/presentation/pages/date_picker_helper.dart';
import 'package:virtual_mentor_app/features/profile/presentation/pages/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.profile});
  final ProfileEntity profile;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _birthCtrl; // Keep as late
  String? _gender;
  File? _avatarFile;
  DateTime? _selectedDate;

  // Helper to get display text for gender
  String? get _displayGender {
    if (_gender == 'M') return 'ذكر';
    if (_gender == 'F') return 'أنثى';
    return null;
  }

  // Format date for display (e.g., "25/06/2026")
  String _formatDateForDisplay(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  // Format date for API (YYYY-MM-DD)
  String _formatDateForAPI(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    final p = widget.profile;

    _firstNameCtrl = TextEditingController(text: p.firstName ?? '');
    _lastNameCtrl = TextEditingController(text: p.lastName ?? '');
    _phoneCtrl = TextEditingController(text: p.profile?.phone ?? '');
    _addressCtrl = TextEditingController(text: p.profile?.address ?? '');

    // Initialize birth date controller properly
    final birthDate = p.profile?.birthDate;
    String initialBirthText = '';

    if (birthDate != null && birthDate.isNotEmpty) {
      try {
        // Try to parse the date (assuming it's in YYYY-MM-DD format from API)
        final date = DateTime.parse(birthDate);
        _selectedDate = date;
        initialBirthText = _formatDateForDisplay(date);
      } catch (e) {
        initialBirthText = birthDate;
      }
    }

    _birthCtrl = TextEditingController(text: initialBirthText);
    _gender = p.profile?.gender;
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _birthCtrl.dispose();
    super.dispose();
  }

  void _save() {
    String? birthDateForAPI;
    if (_selectedDate != null) {
      birthDateForAPI = _formatDateForAPI(_selectedDate!);
    }

    context.read<ProfileCubit>().updateProfile(
      firstName: _firstNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      address: _addressCtrl.text.trim(),
      birthDate: birthDateForAPI,
      gender: _gender,
      avatar: _avatarFile,
    );
  }

  // Date picker method
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('ar', 'SY'),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _birthCtrl.text = _formatDateForDisplay(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'تم حفظ التغييرات بنجاح',
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: AppColors.success,
            ),
          );
          Navigator.pop(context);
        }
        if (state is ProfileUpdateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message, textDirection: TextDirection.rtl),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: context.screenBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.pagePadding,
              vertical: AppSizes.vmd,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Header ────────────────────────────────────────────────
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: AppSizes.iconMd,
                          color: context.textPrimaryColor,
                        ),
                      ),
                      SizedBox(width: AppSizes.sm),
                      Text(
                        'تعديل الملف الشخصي',
                        style: AppTextStyles.titleBold(),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.vlg),

                  // ── Avatar picker ─────────────────────────────────────────
                  Center(
                    child: ProfileImagePicker(
                      image: _avatarFile,
                      onImageSelected: (f) => setState(() => _avatarFile = f),
                    ),
                  ),
                  Center(
                    child: Text(
                      'تعديل الصورة',
                      style: AppTextStyles.captionRegular(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.vmd),

                  // ── Name row ──────────────────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: _firstNameCtrl,
                          label: 'الاسم الأول',
                          hint: 'أحمد',
                        ),
                      ),
                      SizedBox(width: AppSizes.sm),
                      Expanded(
                        child: AppTextField(
                          controller: _lastNameCtrl,
                          label: 'الاسم الأخير',
                          hint: 'أحمد',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.vmd),

                  // ── Phone ─────────────────────────────────────────────────
                  Text('رقم الجوال', style: AppTextStyles.labelRegular()),
                  SizedBox(height: 6.h),
                  Container(
                    decoration: BoxDecoration(
                      color: context.cardBackgroundColor,
                      border: Border.all(color: context.borderColor),
                      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: AppTextField(
                              controller: _phoneCtrl,
                              hint: '999 999 999',
                              keyboardType: TextInputType.phone,
                              showBorder: false,
                            ),
                          ),
                        ),
                        Container(
                          width: 1.w,
                          height: 40.h,
                          color: context.borderColor,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            '+963',
                            style: AppTextStyles.labelRegular(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSizes.vmd),

                  // ── Address ───────────────────────────────────────────────
                  AppTextField(
                    controller: _addressCtrl,
                    label: 'العنوان',
                    hint: 'أدخل عنوانك',
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: AppSizes.vmd),

                  // ── Birth date ────────────────────────────────────────────
                  AppTextField(
                    prefixIcon: Icons.date_range_outlined,
                    controller: _birthCtrl,
                    label: 'تاريخ الميلاد',
                    hint: 'يوم/شهر/سنة',
                    readOnly: true,
                    onTap: () => _selectDate(context),
                  ),
                  SizedBox(height: AppSizes.vmd),

                  // ── Gender toggle ─────────────────────────────────────────
                  _GenderToggle(
                    selected: _displayGender,
                    onChanged: (displayValue) {
                      final apiValue = displayValue == 'ذكر' ? 'M' : 'F';
                      setState(() => _gender = apiValue);
                    },
                  ),
                  SizedBox(height: AppSizes.vlg),

                  // ── Save button ───────────────────────────────────────────
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      final loading = state is ProfileUpdating;
                      return AppButton(
                        label: loading ? '...' : 'حفظ',
                        onTap: loading ? null : _save,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Gender toggle ─────────────────────────────────────────────────────────────

class _GenderToggle extends StatelessWidget {
  const _GenderToggle({required this.selected, required this.onChanged});
  final String? selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    Widget chip(String label, String value) {
      final isSelected = selected == value;
      return Expanded(
        child: GestureDetector(
          onTap: () => onChanged(value),
          child: Container(
            height: 38.h,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.primary),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        chip('ذكر', 'ذكر'),
        SizedBox(width: 10.w),
        chip('أنثى', 'أنثى'),
      ],
    );
  }
}
