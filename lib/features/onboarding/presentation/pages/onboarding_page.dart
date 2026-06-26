// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:virtual_mentor_app/core/widgets/buttons/app_button.dart';
// import '../../../../core/extensions/extensions.dart';
// import '../../../../core/router/app_routes.dart';
// import '../../../../core/storage/shared_prefs_helper.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_sizes.dart';
// import '../../../../core/theme/app_text_styles.dart';
// import '../../../../core/utils/app_assets.dart';
// import '../widgets/onboarding_dot_indicator.dart';

// class _OnboardingItem {
//   final String image;
//   final String Function(BuildContext context) title;
//   final String Function(BuildContext context) subtitle;

//   const _OnboardingItem({
//     required this.image,
//     required this.title,
//     required this.subtitle,
//   });
// }

// class OnboardingPage extends StatefulWidget {
//   const OnboardingPage({super.key});

//   @override
//   State<OnboardingPage> createState() => _OnboardingPageState();
// }

// class _OnboardingPageState extends State<OnboardingPage> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   late final List<_OnboardingItem> _items = [
//     _OnboardingItem(
//       image: AppAssets.onboarding1,
//       title: (ctx) => ctx.tr.onboarding1Title,
//       subtitle: (ctx) => ctx.tr.onboarding1Subtitle,
//     ),
//     _OnboardingItem(
//       image: AppAssets.onboarding2,
//       title: (ctx) => ctx.tr.onboarding2Title,
//       subtitle: (ctx) => ctx.tr.onboarding2Subtitle,
//     ),
//     _OnboardingItem(
//       image: AppAssets.onboarding3,
//       title: (ctx) => ctx.tr.onboarding3Title,
//       subtitle: (ctx) => ctx.tr.onboarding3Subtitle,
//     ),
//   ];

//   bool get _isLastPage => _currentPage == _items.length - 1;

//   void _nextPage() {
//     if (_isLastPage) {
//       _finish();
//     } else {
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 350),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   Future<void> _finish() async {
//     await SharedPrefsHelper.setOnboardingDone();
//     if (!mounted) return;
//     context.go(AppRoutes.welcomingPath);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.screenBackground,
//       body: Stack(
//         children: [
//           // ─── Background shape ─────────────────────────
//           Positioned(
//             top: 0,
//             right: 0,
//             child: SvgPicture.asset(
//               AppAssets.backgroundShape,
//               width: 57.w,
//               height: 1.sh,
//               fit: BoxFit.contain,
//             ),
//           ),

//           SafeArea(
//             child: Column(
//               children: [
//                 // ─── Top bar ──────────────────────────
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: AppSizes.pagePadding,
//                     vertical: 12.h,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Logo + name
//                       Row(
//                         spacing: 10.w,
//                         children: [
//                           Center(
//                             child: Image.asset(
//                               AppAssets.appLogo,
//                               width: 50.w,
//                               height: 50.w,
//                             ),
//                           ),
//                           Text(
//                             context.tr.appName,
//                             style: AppTextStyles.titleMedium(
//                               color: AppColors.primary,
//                             ),
//                           ),
//                         ],
//                       ),
//                       // Skip
//                       if (!_isLastPage)
//                         GestureDetector(
//                           onTap: _finish,
//                           child: Text(
//                             context.tr.skip,
//                             style: AppTextStyles.labelRegular(
//                               color: AppColors.textSecondary,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),

//                 // ─── Page view ────────────────────────
//                 Expanded(
//                   child: PageView.builder(
//                     controller: _pageController,
//                     onPageChanged: (i) => setState(() => _currentPage = i),
//                     itemCount: _items.length,
//                     itemBuilder: (ctx, i) => _OnboardingSlide(item: _items[i]),
//                   ),
//                 ),

//                 // ─── Dots ─────────────────────────────
//                 OnboardingDotIndicator(
//                   count: _items.length,
//                   current: _currentPage,
//                 ),

//                 SizedBox(height: 32.h),

//                 AppButton(
//                   label: _isLastPage ? context.tr.startNow : context.tr.next,
//                   onTap: _nextPage,
//                 ),

//                 SizedBox(height: 32.h),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _OnboardingSlide extends StatelessWidget {
//   final _OnboardingItem item;

//   const _OnboardingSlide({required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: AppSizes.pagePadding),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(AppSizes.radiusMd),
//             ),
//             child: Image.asset(
//               item.image,
//               height: 260.h,
//               fit: BoxFit.contain,
//               width: 270.w,
//             ),
//           ),
//           SizedBox(height: 40.h),
//           Text(
//             item.title(context),
//             style: AppTextStyles.displayBold(color: AppColors.textPrimary),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 16.h),
//           Text(
//             item.subtitle(context),
//             style: AppTextStyles.titleMedium(color: AppColors.textSecondary),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 24.h),
//         ],
//       ),
//     );
//   }
// }
