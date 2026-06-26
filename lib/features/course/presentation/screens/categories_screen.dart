// lib/features/course/presentation/screens/categories_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_mentor_app/core/di/injection_container.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/core/widgets/loading/app_loading.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/category_entity.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_state.dart';
import '../blocs/category/category_bloc.dart';
import '../widgets/category_card.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late final CategoryBloc _categoryBloc;
  CategoryEntity? _selectedCategory;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _categoryBloc = sl<CategoryBloc>()..add(GetCategories());

    // تحميل التخصص الحالي من البروفايل
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileState = context.read<ProfileCubit>().state;
      if (profileState is ProfileLoaded) {
        _selectedCategory = profileState.profile.profile?.currentCategory;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _categoryBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اختر مسارك', style: AppTextStyles.headingM()),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (_isUpdating)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
        ],
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            setState(() {
              _isUpdating = false;
            });
            context.read<ProfileCubit>().loadProfile();
            // تحديث التخصص المختار من البيانات الجديدة
            final profileState = context.read<ProfileCubit>().state;
            if (profileState is ProfileLoaded) {
              setState(() {
                _selectedCategory =
                    profileState.profile.profile?.currentCategory;
              });
            }

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'تم تحديث التخصص بنجاح',
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: AppColors.success,
                duration: Duration(seconds: 2),
              ),
            );
          }
          if (state is ProfileUpdateError) {
            setState(() {
              _isUpdating = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message, textDirection: TextDirection.rtl),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        child: BlocProvider.value(
          value: _categoryBloc,
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const AppLoader(message: 'جاري تحميل التخصصات...');
              } else if (state is CategoryLoaded) {
                return _buildCategoriesGrid(state.categories);
              } else if (state is CategoryFailure) {
                return _buildErrorWidget(state.message);
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesGrid(List<CategoryEntity> categories) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.md.w),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppSizes.md.w,
          mainAxisSpacing: AppSizes.md.h,
          childAspectRatio: 0.85,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory?.id == category.id;
          final isCurrentCategory = _selectedCategory?.id == category.id;

          return CategoryCard(
            category: category,
            isSelected: isSelected,
            isLoading: _isUpdating && isSelected,
            isCurrentCategory: isCurrentCategory,
            onTap: () {
              // الضغط على البطاقة → الذهاب للتفاصيل
              context.push(
                '/categories/${category.id}/subjects',
                extra: category,
              );
            },
            onSelect: () {
              // منع التحديد أثناء التحديث
              if (_isUpdating) return;

              // نحدد التخصص مباشرة محلياً أولاً
              setState(() {
                if (_selectedCategory?.id == category.id) {
                  // إلغاء التحديد
                  _selectedCategory = null;
                } else {
                  // تحديد التخصص الجديد
                  _selectedCategory = category;
                }
              });

              // ثم نرسل التحديث للـ API
              _updateCategory(
                _selectedCategory?.id == category.id ? category : null,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64.w, color: AppColors.error),
          SizedBox(height: AppSizes.md.h),
          Text(
            message,
            style: AppTextStyles.bodyL(color: context.textSecondaryColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSizes.lg.h),
          ElevatedButton(
            onPressed: () {
              _categoryBloc.add(GetCategories());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              ),
            ),
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  // تحديث التخصص
  void _updateCategory(CategoryEntity? category) {
    setState(() {
      _isUpdating = true;
    });

    // تحديث التخصص عبر ProfileCubit
    context.read<ProfileCubit>().updateProfile(
      currentCategoryId: category?.id.toString(),
    );
  }
}
