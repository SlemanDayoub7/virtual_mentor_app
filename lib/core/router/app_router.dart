import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_mentor_app/core/di/injection_container.dart';
import 'package:virtual_mentor_app/features/auth/presentation/screens/account_screen.dart';
import 'package:virtual_mentor_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:virtual_mentor_app/features/auth/presentation/screens/login_screen.dart';
import 'package:virtual_mentor_app/features/auth/presentation/screens/otp_screen.dart';
import 'package:virtual_mentor_app/features/auth/presentation/screens/register_screen.dart';
import 'package:virtual_mentor_app/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/category_entity.dart';
import 'package:virtual_mentor_app/features/course/domain/entities/subject_entity.dart';
import 'package:virtual_mentor_app/features/course/presentation/screens/categories_screen.dart';
import 'package:virtual_mentor_app/features/course/presentation/screens/skills_screen.dart';
import 'package:virtual_mentor_app/features/course/presentation/screens/statistics_screen.dart';
import 'package:virtual_mentor_app/features/course/presentation/screens/subjects_screen.dart';
import 'package:virtual_mentor_app/features/main/pages/main_page.dart';
import 'package:virtual_mentor_app/features/splash/presentation/pages/splash_page.dart';
import '../../core/bloc/session_bloc/session_bloc.dart';

// ─── Route names ──────────────────────────────────────────────────────────────
abstract class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const otp = '/otp';
  static const forgotPassword = '/forgot-password';
  static const resetPassword = '/reset-password';
  static const home = '/home';
  static const account = '/account';
  static const categories = '/categories';
  static const subjects = '/categories/:categoryId/subjects';
  static const skills = '/categories/:categoryId/subjects/:subjectId/skills';
  static const statistics = '/statistics';
}

// ─── Router ───────────────────────────────────────────────────────────────────
GoRouter createRouter(SessionBloc sessionBloc) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    refreshListenable: GoRouterRefreshListenable(sessionBloc),
    redirect: (context, state) async {
      // final session = sessionBloc.state;
      // final location = state.matchedLocation;

      // print(
      //   'Router redirect - Session state: ${session.runtimeType}, Location: $location',
      // );

      // // حالة التحميل - ابق على شاشة Splash
      // if (session is SessionInitial) {
      //   print('Still on splash screen - waiting for session check');
      //   return null;
      // }

      // IMPORTANT: معالجة شاشة Splash بشكل خاص
      if (location == AppRoutes.splash) {
        await Future.delayed(Duration(seconds: 2));
        if (session is SessionAuthenticated) {
          print('Authenticated user on splash -> redirecting to home');
          return AppRoutes.home;
        }
        if (session is SessionUnauthenticated) {
          print('Unauthenticated user on splash -> redirecting to login');
          return AppRoutes.login;
        }
      }

      // للمستخدم غير المسجل الدخول - اذا حاول دخول صفحات protected
      if (session is SessionUnauthenticated) {
        // قائمة الصفحات المسموحة للمستخدم غير المسجل
        const publicRoutes = {
          AppRoutes.login,
          AppRoutes.register,
          AppRoutes.otp,
          AppRoutes.forgotPassword,
          AppRoutes.resetPassword,
          AppRoutes.home,
        };

      //   if (!publicRoutes.contains(location)) {
      //     print(
      //       'Unauthenticated user trying to access $location -> redirecting to login',
      //     );
      //     return AppRoutes.login;
      //   }
      // }

      // // للمستخدم المسجل الدخول - اذا حاول دخول صفحات auth
      // if (session is SessionAuthenticated) {
      //   const authRoutes = {
      //     AppRoutes.login,
      //     AppRoutes.register,
      //     AppRoutes.otp,
      //     AppRoutes.forgotPassword,
      //     AppRoutes.resetPassword,
      //   };

      //   if (authRoutes.contains(location)) {
      //     print(
      //       'Authenticated user trying to access auth page $location -> redirecting to home',
      //     );
      //     return AppRoutes.home;
      //   }
      // }

      // print('No redirect needed - staying on $location');
      return null;
    },
    routes: [
      // ── Splash / initial ──────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // ── Auth routes ───────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        name: 'otp',
        builder: (context, state) {
          final email = state.extra as String;
          return OtpScreen(email: email);
        },
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        name: 'resetPassword',
        builder: (context, state) {
          final email = state.extra as String;
          return ResetPasswordScreen(email: email);
        },
      ),

      // ── Authenticated routes ───────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => MainPage(),
      ),
      GoRoute(
        path: AppRoutes.account,
        name: 'account',
        builder: (context, state) => const AccountScreen(),
      ),
      GoRoute(
        path: AppRoutes.categories,
        name: 'categories',
        builder: (context, state) => CategoriesScreen(),
      ),
      GoRoute(
        path: AppRoutes.subjects,
        name: 'subjects',
        builder: (context, state) {
          final category = state.extra as CategoryEntity;
          return SubjectsScreen(category: category);
        },
      ),
      GoRoute(
        path: AppRoutes.skills,
        name: 'skills',
        builder: (context, state) {
          final subject = state.extra as SubjectEntity;
          return SkillsScreen(subject: subject);
        },
      ),
      GoRoute(
        path: AppRoutes.statistics,
        name: 'statistics',
        builder: (context, state) => const StatisticsScreen(),
      ),
    ],
  );
}

// Custom refresh listenable that properly notifies GoRouter when bloc changes
class GoRouterRefreshListenable extends ChangeNotifier {
  final SessionBloc bloc;
  late final StreamSubscription<SessionState> _subscription;

  GoRouterRefreshListenable(this.bloc) {
    _subscription = bloc.stream.listen((_) {
      print('Session state changed - notifying router');
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
