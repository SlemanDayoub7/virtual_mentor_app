import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_mentor_app/features/onboarding/presentation/pages/welcoming_page.dart';
import 'package:virtual_mentor_app/features/profile/presentation/pages/profile.dart';
import 'package:virtual_mentor_app/features/register/presentation/pages/login.dart';
import 'package:virtual_mentor_app/features/verification/presentaion/pages/verification-success.dart';
import 'package:virtual_mentor_app/features/verification/presentaion/pages/account-verification.dart';
import 'package:virtual_mentor_app/features/verification/presentaion/pages/return-account-verification.dart';

import '../../features/register/presentation/pages/register.dart';
import '../../features/home/router/home_routes.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.verifySuccessFull,
    routes: [
      // ─── Splash ───────────────────────────────────
      GoRoute(
        path: AppRoutes.rootPath,
        name: AppRoutes.splash,
        builder: (_, __) => const SplashPage(),
      ),

      // ─── Onboarding ───────────────────────────────
      GoRoute(
        path: AppRoutes.onboardingPath,
        name: AppRoutes.onboarding,
        builder: (_, __) => const OnboardingPage(),
      ),
      // ─── Welcoming ───────────────────────────────
      GoRoute(
        path: '${AppRoutes.welcomingPath}/${AppRoutes.welcoming}',
        name: AppRoutes.welcoming,
        builder: (_, __) => const WelcomingPage(),
      ),

      // ─── Register ───────────────────────────────
      GoRoute(
        path: '${AppRoutes.authPath}/${AppRoutes.register}',
        name: AppRoutes.register,
        builder: (_, __) => const RegisterScreen(),
      ),
      // ─── login ───────────────────────────────
      GoRoute(
        path: '${AppRoutes.authPath}/${AppRoutes.login}',
        name: AppRoutes.login,
        builder: (_, __) => const LoginScreen(),
      ),
      
      // ─── Verification Success ───────────────────────────────
      GoRoute(
        path: '${AppRoutes.authPath}/${AppRoutes.verifySuccess}',
        name: AppRoutes.verifySuccess,
        builder: (_, __) => const VerificationSuccessScreen(),
      ),
      
      // ─── Account Verification ──────────────────────────────
      GoRoute(
        path: '${AppRoutes.authPath}/${AppRoutes.accountVerification}',
        name: AppRoutes.accountVerification,
        builder: (_, __) => const AccountVerficationScreen(),
      ),

      // ─── Return Account Verification ──────────────────────
      GoRoute(
        path: '${AppRoutes.authPath}/${AppRoutes.returnAccountVerification}',
        name: AppRoutes.returnAccountVerification,
        builder: (_, __) => const ReturnAccountScreen(),
      ),
       GoRoute(
        path: '${AppRoutes.authPath}/${AppRoutes.profile}',
        name: AppRoutes.profile,
        builder: (_, __) => const CompleteProfileScreen(),
      ),
      // ─── Main ─────────────────────────────────────
GoRoute(
        path:'${AppRoutes.mainPath}/${AppRoutes.mentors}',
        builder: (_, __) => const SizedBox.shrink(),
        routes: homeRoutes,
      ),
      // ─── Complete Profile (Direct) ──────────────────────────────
    ],
    errorBuilder: (_, __) => const _RouteNotFoundPage(),
  );
}
class _RouteNotFoundPage extends StatelessWidget {
  const _RouteNotFoundPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('404 - Page not found')));
  }
}
