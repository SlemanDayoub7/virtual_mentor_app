// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:virtual_mentor_app/core/widgets/buttons/app_button.dart';

// import '../../../../core/extensions/extensions.dart';
// import '../../../../core/router/app_routes.dart';

// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_sizes.dart';
// import '../../../../core/theme/app_text_styles.dart';
// import '../../../../core/utils/app_assets.dart';

// class WelcomingPage extends StatefulWidget {
//   const WelcomingPage({super.key});

//   @override
//   State<WelcomingPage> createState() => _OnboardingPageState();
// }

// class _OnboardingPageState extends State<WelcomingPage> {
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
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: AppSizes.pagePadding,
//                 vertical: 12.h,
//               ),
//               child: Column(
//                 children: [
//                   // ─── Top bar ──────────────────────────
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     spacing: 10.w,
//                     children: [
//                       Center(
//                         child: Image.asset(
//                           AppAssets.appLogo,
//                           width: 50.w,
//                           height: 50.w,
//                         ),
//                       ),
//                       Text(
//                         context.tr.appName,
//                         style: AppTextStyles.titleMedium(
//                           color: AppColors.primary,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 40.h),
//                   const WelcomingSlide(),

//                   AppButton(
//                     label: context.tr.register,
//                     onTap: () {
//                       context.go(AppRoutes.registerFull);
//                     },
//                   ),
//                   SizedBox(height: 15.h),
//                   AppButton(
//                     label: context.tr.login,
//                     onTap: () {
//                       context.go(AppRoutes.loginFull);
//                     },
//                     type: AppButtonType.outline,
//                   ),

//                   SizedBox(height: 32.h),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class WelcomingSlide extends StatelessWidget {
//   const WelcomingSlide();

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
//               AppAssets.welcoming,
//               height: 337.h,
//               fit: BoxFit.contain,
//               width: 337.w,
//             ),
//           ),
//           SizedBox(height: 40.h),
//           Text(
//             context.tr.welcomingTitle,
//             style: AppTextStyles.displayBold(color: AppColors.textPrimary),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 16.h),
//           Text(
//             context.tr.welcomingSubTitle,
//             style: AppTextStyles.titleMedium(color: AppColors.textSecondary),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 80.h),
//         ],
//       ),
//     );
//   }
// }
