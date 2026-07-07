import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/core/utils/app_assets.dart';
import 'package:virtual_mentor_app/features/course/presentation/screens/statistics_screen.dart';
import 'package:virtual_mentor_app/features/home/presentation/pages/home_tab.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:virtual_mentor_app/features/profile/presentation/pages/profile_tab.dart';

/// Bottom navigation tab descriptor
class _NavItem {
  const _NavItem({required this.svgAsset, required this.label});

  final String svgAsset;
  final String label;
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfileCubit>().loadProfile();
  }

  int _selectedIndex = 0;

  // يتم حفظ حالة جميع الصفحات في IndexedStack
  // الترتيب: المواد (0) ← الإحصائيات (1) ← ملفي (2)
  static const List<Widget> _pages = [
    HomeTab(), // المواد
    StatisticsScreen(), // الإحصائيات
    ProfileTab(), // ملفي
  ];

  // عناصر التبويب السفلية - بنفس ترتيب _pages
  static const List<_NavItem> _navItems = [
    _NavItem(svgAsset: AppAssets.homeTab, label: 'المواد'),
    _NavItem(svgAsset: AppAssets.statsTab, label: 'الإحصائيات'),
    _NavItem(svgAsset: AppAssets.profileTab, label: 'ملفي'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
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
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                color: Colors.transparent, // Makes the blur visible
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: AppSizes.bottomNavHeight),
            child: IndexedStack(index: _selectedIndex, children: _pages),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: 1.sw,
              child: _BottomNav(
                selectedIndex: _selectedIndex,
                items: _navItems,
                onItemTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Bottom Navigation Bar ──────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  const _BottomNav({
    required this.selectedIndex,
    required this.items,
    required this.onItemTap,
  });

  final int selectedIndex;
  final List<_NavItem> items;
  final ValueChanged<int> onItemTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.bottomNavHeight,
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.pagePadding,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: context.surfaceVariantColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: context.borderColor.withOpacity(0.3),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      // استخدام Directionality لتحديد اتجاه النص
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            items.length,
            (index) => _NavItemWidget(
              svgAsset: items[index].svgAsset,
              label: items[index].label,
              isSelected: selectedIndex == index,
              onTap: () => onItemTap(index),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Bottom Navigation Item ──────────────────────────────────────────────────

class _NavItemWidget extends StatelessWidget {
  const _NavItemWidget({
    required this.svgAsset,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String svgAsset;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        isSelected ? context.primaryColor : context.textSecondaryColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.vsm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svgAsset,
              width: AppSizes.iconLg,
              height: AppSizes.iconLg,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            SizedBox(height: AppSizes.vxs),
            Text(label, style: AppTextStyles.captionRegular(color: color)),
          ],
        ),
      ),
    );
  }
}

// ── Placeholder for unimplemented tabs ──────────────────────────────────────

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(label, style: AppTextStyles.titleMedium()));
  }
}
