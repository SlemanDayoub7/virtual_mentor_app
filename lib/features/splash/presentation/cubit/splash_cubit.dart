import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_mentor_app/core/bloc/session_bloc/session_bloc.dart';
import 'package:virtual_mentor_app/core/di/injection_container.dart';

import '../../../../core/storage/secure_storage_helper.dart';

// States
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashNavigateToNext extends SplashState {}

// Cubit
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> checkAndNavigate() async {
    // Add delay for splash animation
    await Future.delayed(const Duration(seconds: 2));

    // Check if user has tokens
    final hasTokens = await SecureStorageHelper.hasTokens();

    if (hasTokens) {
      sl<SessionBloc>().add(SessionStarted());
    } else {
      sl<SessionBloc>().add(SessionExpired());
    }

    // Emit navigation state
    emit(SplashNavigateToNext());
  }
}
