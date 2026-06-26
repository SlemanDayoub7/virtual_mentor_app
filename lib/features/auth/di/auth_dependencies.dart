import 'package:get_it/get_it.dart';
import 'package:virtual_mentor_app/features/auth/data/datasources/auth_remote_datasource.dart';

import 'package:virtual_mentor_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:virtual_mentor_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:virtual_mentor_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:virtual_mentor_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:virtual_mentor_app/features/auth/domain/usecases/update_me_use_case.dart';
import 'package:virtual_mentor_app/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:virtual_mentor_app/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:virtual_mentor_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:virtual_mentor_app/features/auth/domain/usecases/google_login_usecase.dart';
import 'package:virtual_mentor_app/features/auth/domain/usecases/get_me_usecase.dart';
import 'package:virtual_mentor_app/features/auth/domain/usecases/password_usecases.dart';
import 'package:virtual_mentor_app/features/auth/presentation/blocs/account_bloc.dart';
import 'package:virtual_mentor_app/features/auth/presentation/blocs/login_bloc.dart';
import 'package:virtual_mentor_app/features/auth/presentation/blocs/otp_bloc.dart';
import 'package:virtual_mentor_app/features/auth/presentation/blocs/password_bloc.dart';
import 'package:virtual_mentor_app/features/auth/presentation/blocs/register_bloc.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_cubit.dart';

void registerAuthDependencies(GetIt sl) {
  // ── Data source ───────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // ── Repository ────────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // ── Use cases ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResendOtpUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GoogleLoginUseCase(sl()));
  sl.registerLazySingleton(() => GetMeUseCase(sl()));
  sl.registerLazySingleton(() => UpdateMeUseCase(sl()));
  sl.registerLazySingleton(() => DeleteMeUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));

  // ── Blocs (factory — new instance per screen) ─────────────────────────────
  sl.registerFactory(() => RegisterBloc(sl()));
  sl.registerFactory(() => OtpBloc(sl(), sl()));
  sl.registerFactory(() => LoginBloc(sl(), sl()));
  sl.registerFactory(() => AccountBloc(sl(), sl(), sl()));
  sl.registerFactory(
    () => ProfileCubit(
      getMe: sl(),
      updateMe: sl(),
      deleteMe: sl(),
      changePassword: sl(),
    ),
  );
  sl.registerFactory(() => PasswordBloc(sl(), sl(), sl()));
}
