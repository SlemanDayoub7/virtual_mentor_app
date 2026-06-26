import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/features/auth/presentation/blocs/account_bloc.dart';
import 'package:virtual_mentor_app/features/auth/presentation/blocs/login_bloc.dart';
import 'package:virtual_mentor_app/features/auth/presentation/blocs/otp_bloc.dart';
import 'package:virtual_mentor_app/features/auth/presentation/blocs/password_bloc.dart';
import 'package:virtual_mentor_app/features/auth/presentation/blocs/register_bloc.dart';
import 'package:virtual_mentor_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:virtual_mentor_app/l10n/app_localizations.dart';
import 'core/bloc/locale_bloc/locale_bloc.dart';
import 'core/bloc/session_bloc/session_bloc.dart';
import 'core/bloc/theme_bloc/theme_bloc.dart';
import 'core/di/injection_container.dart';
import 'core/router/app_router.dart';

import 'core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: sl<SessionBloc>()),
            BlocProvider.value(value: sl<ThemeBloc>()),
            BlocProvider.value(value: sl<LocaleBloc>()),
            BlocProvider(create: (_) => sl<LoginBloc>()),
            BlocProvider(create: (_) => sl<RegisterBloc>()),
            BlocProvider(create: (_) => sl<AccountBloc>()),
            BlocProvider(create: (_) => sl<OtpBloc>()),
            BlocProvider(create: (_) => sl<ProfileCubit>()),
            BlocProvider(create: (_) => sl<PasswordBloc>()),
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return BlocBuilder<LocaleBloc, LocaleState>(
                builder: (context, localeState) {
                  return MaterialApp.router(
                    title: 'Virtual Mentor',
                    debugShowCheckedModeBanner: false,

                    // ─── Theme ────────────────────────────────
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    themeMode: themeState.themeMode,

                    // ─── Locale ───────────────────────────────
                    locale: localeState.locale,
                    supportedLocales: AppLocalizations.supportedLocales,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    routerConfig: createRouter(sl<SessionBloc>()),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
