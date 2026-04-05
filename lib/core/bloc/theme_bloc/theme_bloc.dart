import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../storage/shared_prefs_helper.dart';

// ─── Events ───────────────────────────────────────────────────────────────────
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object?> get props => [];
}

class ThemeToggled extends ThemeEvent {}

class ThemeSet extends ThemeEvent {
  final ThemeMode mode;
  const ThemeSet(this.mode);
  @override
  List<Object?> get props => [mode];
}

class ThemeLoaded extends ThemeEvent {}

// ─── State ────────────────────────────────────────────────────────────────────
class ThemeState extends Equatable {
  final ThemeMode themeMode;
  const ThemeState({required this.themeMode});

  bool get isDark => themeMode == ThemeMode.dark;

  @override
  List<Object?> get props => [themeMode];
}

// ─── Bloc ─────────────────────────────────────────────────────────────────────
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(const ThemeState(themeMode: ThemeMode.light)) {
    on<ThemeLoaded>(_onLoaded);
    on<ThemeToggled>(_onToggled);
    on<ThemeSet>(_onSet);
  }

  void _onLoaded(ThemeLoaded event, Emitter<ThemeState> emit) {
    final saved = SharedPrefsHelper.getThemeMode();
    final mode = saved == 'dark' ? ThemeMode.dark : ThemeMode.light;
    emit(ThemeState(themeMode: mode));
  }

  Future<void> _onToggled(ThemeToggled event, Emitter<ThemeState> emit) async {
    final newMode =
        state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await SharedPrefsHelper.saveThemeMode(
        newMode == ThemeMode.dark ? 'dark' : 'light');
    emit(ThemeState(themeMode: newMode));
  }

  Future<void> _onSet(ThemeSet event, Emitter<ThemeState> emit) async {
    await SharedPrefsHelper.saveThemeMode(
        event.mode == ThemeMode.dark ? 'dark' : 'light');
    emit(ThemeState(themeMode: event.mode));
  }
}
