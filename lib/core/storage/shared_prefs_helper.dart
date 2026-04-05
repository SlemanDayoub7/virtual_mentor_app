import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ─── Theme ──────────────────────────────────────────────
  static const _themeKey = 'theme_mode';

  static Future<void> saveThemeMode(String mode) async =>
      await _prefs.setString(_themeKey, mode);

  static String? getThemeMode() => _prefs.getString(_themeKey);

  // ─── Locale ─────────────────────────────────────────────
  static const _localeKey = 'locale';

  static Future<void> saveLocale(String locale) async =>
      await _prefs.setString(_localeKey, locale);

  static String? getLocale() => _prefs.getString(_localeKey);

  // ─── Onboarding ─────────────────────────────────────────
  static const _onboardingKey = 'onboarding_done';

  static Future<void> setOnboardingDone() async =>
      await _prefs.setBool(_onboardingKey, true);

  static bool isOnboardingDone() => _prefs.getBool(_onboardingKey) ?? false;

  // ─── Generic ────────────────────────────────────────────
  static Future<void> clear() async => await _prefs.clear();
}
