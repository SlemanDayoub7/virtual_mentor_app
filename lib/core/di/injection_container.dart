import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import '../../features/home/di/home_injection.dart';
import '../bloc/locale_bloc/locale_bloc.dart';
import '../bloc/session_bloc/session_bloc.dart';
import '../bloc/theme_bloc/theme_bloc.dart';
import '../networking/dio_client.dart';
import '../networking/network_info.dart';

final sl = GetIt.instance;

Future<void> setupInjection() async {
  // ─── Core ──────────────────────────────────────────────────
  _setupCore();

  // ─── App-level BLoCs ──────────────────────────────────────
  _setupAppBlocs();

  // ─── Features ─────────────────────────────────────────────

  setupHomeInjection();
  // Add more features here:
  // setupMentorInjection();
  // setupSessionsInjection();
  // setupProfileInjection();
}

void _setupCore() {
  // Connectivity
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Dio Client
  sl.registerLazySingleton(() => DioClient());
}

void _setupAppBlocs() {
  // Singletons — app-wide, one instance
  sl.registerSingleton(SessionBloc());
  sl.registerSingleton(ThemeBloc());
  sl.registerSingleton(LocaleBloc());
}
