import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../storage/shared_prefs_helper.dart';

// ─── Events ───────────────────────────────────────────────────────────────────
abstract class LocaleEvent extends Equatable {
  const LocaleEvent();
  @override
  List<Object?> get props => [];
}

class LocaleLoaded extends LocaleEvent {}

class LocaleChanged extends LocaleEvent {
  final String languageCode;
  const LocaleChanged(this.languageCode);
  @override
  List<Object?> get props => [languageCode];
}

// ─── State ────────────────────────────────────────────────────────────────────
class LocaleState extends Equatable {
  final Locale locale;
  const LocaleState({required this.locale});

  bool get isArabic => locale.languageCode == 'ar';

  @override
  List<Object?> get props => [locale];
}

// ─── Bloc ─────────────────────────────────────────────────────────────────────
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(const LocaleState(locale: Locale('ar'))) {
    on<LocaleLoaded>(_onLoaded);
    on<LocaleChanged>(_onChanged);
  }

  void _onLoaded(LocaleLoaded event, Emitter<LocaleState> emit) {
    // final saved = SharedPrefsHelper.getLocale();
    // final locale = Locale(saved ?? 'ar');
    emit(LocaleState(locale: Locale('ar')));
  }

  Future<void> _onChanged(
    LocaleChanged event,
    Emitter<LocaleState> emit,
  ) async {
    await SharedPrefsHelper.saveLocale(event.languageCode);
    emit(LocaleState(locale: Locale(event.languageCode)));
  }
}
