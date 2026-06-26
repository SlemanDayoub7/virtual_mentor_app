import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:virtual_mentor_app/l10n/app_localizations.dart';
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

  // ─── Brand Colors ──────────────────────────────────────────────────────────
  Color get primaryColor => isDark ? AppColors.primaryDark : AppColors.primary;
  Color get primaryDarkColor =>
      isDark ? AppColors.primaryDark : AppColors.primaryDark;
  Color get primaryLightColor =>
      isDark ? AppColors.primaryLight : AppColors.primaryLight;
  Color get skyBlueColor => isDark ? AppColors.skyBlue : AppColors.skyBlue;

  // ─── Background Colors ─────────────────────────────────────────────────────
  Color get backgroundColor =>
      isDark ? AppColors.darkBackground : AppColors.lightBackground;
  Color get screenBackgroundColor =>
      isDark ? AppColors.darkBackground : AppColors.screenBackground;
  Color get cardBackgroundColor =>
      isDark ? AppColors.darkSurface : AppColors.cardBackground;
  Color get surfaceColor =>
      isDark ? AppColors.darkSurface : AppColors.lightSurface;
  Color get surfaceVariantColor =>
      isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant;

  // ─── Text Colors ───────────────────────────────────────────────────────────
  Color get textPrimaryColor =>
      isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
  Color get textSecondaryColor =>
      isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
  Color get textHintColor =>
      isDark ? AppColors.darkTextHint : AppColors.lightTextHint;

  // ─── UI Colors ─────────────────────────────────────────────────────────────
  Color get borderColor =>
      isDark ? AppColors.darkBorder : AppColors.lightBorder;
  Color get dividerColor =>
      isDark ? AppColors.darkDivider : AppColors.lightDivider;
  Color get iconColor => isDark ? AppColors.darkIcon : AppColors.lightIcon;

  // ─── Semantic Colors ───────────────────────────────────────────────────────
  Color get errorColor => AppColors.error;
  Color get successColor => AppColors.success;

  // ─── Static Colors ─────────────────────────────────────────────────────────
  Color get whiteColor => AppColors.white;
  Color get blackColor => AppColors.black;
  Color get transparentColor => AppColors.transparent;

  // ─── Grey Scale ────────────────────────────────────────────────────────────
  Color get grey100Color => AppColors.grey100;
  Color get grey200Color => AppColors.grey200;
  Color get grey400Color => AppColors.grey400;
  Color get grey500Color => AppColors.grey500;
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
