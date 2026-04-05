import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ─── Brand ───────────────────────────────────────────────
  static const Color primary = Color(0xFF4F7CF7);
  static const Color primaryDark = Color(0xFF3F6AE6);
  static const Color primaryLight = Color(0xFF7FA6FF);
  static const Color skyBlue = Color(0xFFE9F0FF);

  // ─── Text ─────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);

  // ─── UI ───────────────────────────────────────────────────
  static const Color border = Color(0xFFE5E7EB);
  static const Color cardBackground = Color(0xFFF5F7FB);
  static const Color screenBackground = Color(0xFFFFFFFF);

  // ─── Semantic ─────────────────────────────────────────────
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF22C55E);

  // ─── Gradients ────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient splashGradient = LinearGradient(
    colors: [skyBlue, screenBackground],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  // ─── Static ───────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;

  // ─── Light Theme tokens (map to above) ───────────────────
  static const Color lightBackground = screenBackground;
  static const Color lightSurface = cardBackground;
  static const Color lightSurfaceVariant = skyBlue;
  static const Color lightBorder = border;
  static const Color lightTextPrimary = textPrimary;
  static const Color lightTextSecondary = textSecondary;
  static const Color lightTextHint = Color(0xFFB0B7C3);
  static const Color lightIcon = textSecondary;
  static const Color lightDivider = border;

  // ─── Dark Theme tokens ────────────────────────────────────
  static const Color darkBackground = Color(0xFF0D1117);
  static const Color darkSurface = Color(0xFF161B22);
  static const Color darkSurfaceVariant = Color(0xFF21262D);
  static const Color darkBorder = Color(0xFF30363D);
  static const Color darkTextPrimary = Color(0xFFE6EDF3);
  static const Color darkTextSecondary = Color(0xFF8B949E);
  static const Color darkTextHint = Color(0xFF484F58);
  static const Color darkIcon = Color(0xFF8B949E);
  static const Color darkDivider = Color(0xFF21262D);

  // ─── Grey Scale ───────────────────────────────────────────
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
}
