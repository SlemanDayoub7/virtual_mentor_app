import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/storage/secure_storage_helper.dart';
import '../../../../core/storage/shared_prefs_helper.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_assets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    _controller.forward();
    Future.delayed(const Duration(seconds: 3), _navigate);
  }

  Future<void> _navigate() async {
    if (!mounted) return;
    final isLoggedIn = await SecureStorageHelper.hasTokens();
    final isOnboardingDone = SharedPrefsHelper.isOnboardingDone();

    if (isLoggedIn) {
      context.go(AppRoutes.homeFull);
    } else if (!isOnboardingDone) {
      context.go(AppRoutes.onboardingPath);
    } else {
      context.go(AppRoutes.welcomingPath);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: Stack(
        children: [
          // ─── Background shape ─────────────────────────
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

          // ─── Center content ───────────────────────────
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ─── Logo ───────────────────────────
                    Center(
                      child: Image.asset(
                        AppAssets.appLogo,
                        fit: BoxFit.fill,
                        width: 104.w,
                        height: 97.h,
                      ),
                    ),

                    SizedBox(height: 35.h),

                    // ─── App name ───────────────────────
                    Text(
                      context.tr.appName,
                      style: AppTextStyles.displayBold(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
