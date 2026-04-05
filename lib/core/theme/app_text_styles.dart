import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppFonts {
  AppFonts._();
  static const String primary = 'Tajawal';
}

class AppTextStyles {
  AppTextStyles._();

  // ─── Display Bold 32 (headings) ───────────────────────────
  static TextStyle displayBold({Color? color}) => TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    height: 1.0,
    letterSpacing: 0,
    color: color ?? AppColors.textPrimary,
  );
  // ─── Title Bold 20 ──────────────────────────────────────
  static TextStyle titleBold({Color? color}) => TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    height: 1.0,
    letterSpacing: 0,
    color: color ?? AppColors.textPrimary,
  );
  // ─── Title Medium 20 ──────────────────────────────────────
  static TextStyle titleMedium({Color? color}) => TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: 0,
    color: color ?? AppColors.textPrimary,
  );

  // ─── Body Bold 16 ─────────────────────────────────────────
  static TextStyle bodyBold({Color? color}) => TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    height: 1.0,
    letterSpacing: 0,
    color: color ?? AppColors.textPrimary,
  );

  // ─── Body Regular 16 ──────────────────────────────────────
  static TextStyle bodyRegular({Color? color}) => TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0,
    color: color ?? AppColors.textPrimary,
  );

  // ─── Label Regular 14 ─────────────────────────────────────
  static TextStyle labelRegular({Color? color}) => TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0,
    color: color ?? AppColors.textSecondary,
  );

  // ─── Caption Regular 12 ───────────────────────────────────
  static TextStyle captionRegular({Color? color}) => TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0,
    color: color ?? AppColors.textSecondary,
  );

  // ─── Button 16 Bold ───────────────────────────────────────
  static TextStyle button({Color? color}) => TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    height: 1.0,
    letterSpacing: 0,
    color: color ?? AppColors.white,
  );

  // ─── Aliases for backward compat ──────────────────────────
  static TextStyle headingL({Color? color}) => displayBold(color: color);
  static TextStyle headingM({Color? color}) => titleMedium(color: color);
  static TextStyle headingS({Color? color}) => bodyBold(color: color);
  static TextStyle bodyL({Color? color}) => bodyRegular(color: color);
  static TextStyle bodyM({Color? color}) => labelRegular(color: color);
  static TextStyle bodyS({Color? color}) => captionRegular(color: color);
  static TextStyle labelM({Color? color}) => labelRegular(color: color);
  static TextStyle labelS({Color? color}) => captionRegular(color: color);
  static TextStyle caption({Color? color}) => captionRegular(color: color);
  static TextStyle displayMedium({Color? color}) => displayBold(color: color);
  static TextStyle displayLarge({Color? color}) => displayBold(color: color);
  static TextStyle labelL({Color? color}) => bodyBold(color: color);
  static TextStyle link({Color? color}) =>
      labelRegular(color: color ?? AppColors.primary).copyWith(
        decoration: TextDecoration.underline,
        decorationColor: color ?? AppColors.primary,
      );
}
