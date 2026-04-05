import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_mentor_app/features/onboarding/presentation/pages/welcoming_page.dart';
import '../../features/home/router/home_routes.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.rootPath,
    debugLogDiagnostics: true,
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
        path: AppRoutes.welcomingPath,
        name: AppRoutes.welcoming,
        builder: (_, __) => const WelcomingPage(),
      ),

      // ─── Main ─────────────────────────────────────
      GoRoute(
        path: AppRoutes.mainPath,
        builder: (_, __) => const SizedBox.shrink(),
        routes: homeRoutes,
      ),
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
