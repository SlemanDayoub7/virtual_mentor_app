import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtual_mentor_app/core/bloc/session_bloc/session_bloc.dart';
import 'app.dart';
import 'core/bloc/locale_bloc/locale_bloc.dart';
import 'core/bloc/theme_bloc/theme_bloc.dart';
import 'core/di/injection_container.dart';
import 'core/storage/shared_prefs_helper.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  // ─── System UI ────────────────────────────────────────────
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  // ─── Lock Orientation ─────────────────────────────────────
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ─── SharedPreferences ────────────────────────────────────
  await SharedPrefsHelper.init();

  // ─── Dependency Injection ─────────────────────────────────
  await setupInjection();

  // ─── Load Saved Theme & Locale ────────────────────────────
  sl<ThemeBloc>().add(ThemeLoaded());
  sl<LocaleBloc>().add(LocaleLoaded());
  sl<SessionBloc>().add(SessionStarted());
  runApp(const App());
}
