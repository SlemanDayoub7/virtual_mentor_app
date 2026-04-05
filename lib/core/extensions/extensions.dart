import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../theme/app_colors.dart';

// ─── Translation Extension ────────────────────────────────────────────────────
extension TranslationExtension on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this)!;
}

// ─── Theme Extension ──────────────────────────────────────────────────────────
extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get backgroundColor =>
      isDark ? AppColors.darkBackground : AppColors.lightBackground;
  Color get surfaceColor =>
      isDark ? AppColors.darkSurface : AppColors.lightSurface;
  Color get textPrimary =>
      isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
  Color get textSecondary =>
      isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
  Color get textHint =>
      isDark ? AppColors.darkTextHint : AppColors.lightTextHint;
  Color get borderColor =>
      isDark ? AppColors.darkBorder : AppColors.lightBorder;
  Color get dividerColor =>
      isDark ? AppColors.darkDivider : AppColors.lightDivider;
  Color get iconColor => isDark ? AppColors.darkIcon : AppColors.lightIcon;
  Color get surfaceVariant =>
      isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant;
}

// ─── Navigation Extension ─────────────────────────────────────────────────────
extension NavigationExtension on BuildContext {
  void pushNamed(String route, {Object? extra, Map<String, String>? params}) =>
      GoRouter.of(
        this,
      ).pushNamed(route, extra: extra, pathParameters: params ?? {});

  void goNamed(String route, {Object? extra, Map<String, String>? params}) =>
      GoRouter.of(
        this,
      ).goNamed(route, extra: extra, pathParameters: params ?? {});

  void push(String path) => GoRouter.of(this).push(path);
  void go(String path) => GoRouter.of(this).go(path);
  void pop([Object? result]) => GoRouter.of(this).pop(result);
  bool canPop() => GoRouter.of(this).canPop();
}

// ─── Spacing Extension ────────────────────────────────────────────────────────
extension SpacingExtension on num {
  SizedBox get hSpace => SizedBox(width: toDouble());
  SizedBox get vSpace => SizedBox(height: toDouble());
}

// ─── Padding Extension ────────────────────────────────────────────────────────
extension PaddingExtension on Widget {
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget paddingOnly({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
    ),
    child: this,
  );
}

// ─── String Extensions ────────────────────────────────────────────────────────
extension StringExtension on String {
  bool get isValidEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  bool get isValidPhone => RegExp(r'^\+?[0-9]{8,15}$').hasMatch(this);

  String get capitalizeFirst =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  String get capitalizeWords => split(' ')
      .map(
        (word) =>
            word.isEmpty
                ? word
                : '${word[0].toUpperCase()}${word.substring(1)}',
      )
      .join(' ');
}

// ─── Media Query Extension ────────────────────────────────────────────────────
extension MediaQueryExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  double get topPadding => MediaQuery.of(this).padding.top;
  double get bottomPadding => MediaQuery.of(this).padding.bottom;
  bool get isKeyboardOpen => MediaQuery.of(this).viewInsets.bottom > 0;
}
