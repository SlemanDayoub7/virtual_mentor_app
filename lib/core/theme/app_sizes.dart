import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  AppSizes._();

  // ─── Design Base ──────────────────────────────────────────
  static const double designWidth = 390;
  static const double designHeight = 844;

  // ─── Spacing ──────────────────────────────────────────────
  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 12.w;
  static double get lg => 16.w;
  static double get xl => 20.w;
  static double get xxl => 24.w;
  static double get xxxl => 32.w;
  static double get huge => 48.w;
  static double get giant => 64.w;

  // ─── Vertical Spacing ─────────────────────────────────────
  static double get vxs => 4.h;
  static double get vsm => 8.h;
  static double get vmd => 12.h;
  static double get vlg => 16.h;
  static double get vxl => 20.h;
  static double get vxxl => 24.h;
  static double get vxxxl => 32.h;
  static double get vhuge => 48.h;
  static double get vgiant => 64.h;

  // ─── Border Radius ────────────────────────────────────────
  static double get radiusXs => 4.r;
  static double get radiusSm => 8.r;
  static double get radiusMd => 12.r;
  static double get radiusLg => 16.r;
  static double get radiusXl => 20.r;
  static double get radiusXxl => 24.r;
  static double get radiusFull => 100.r;

  // ─── Icon Sizes ───────────────────────────────────────────
  static double get iconXs => 12.w;
  static double get iconSm => 16.w;
  static double get iconMd => 20.w;
  static double get iconLg => 24.w;
  static double get iconXl => 32.w;
  static double get iconXxl => 48.w;

  // ─── Primary Button (from design specs) ──────────────────
  static double get buttonWidth => 342.w;
  static double get buttonHeight => 56.h;
  static double get buttonHeightSm => 40.h;
  static double get buttonRadius => 16.r;

  // ─── Onboarding Dot ──────────────────────────────────────
  static double get dotWidth => 30.w;
  static double get dotHeight => 15.h;
  static double get dotSmallWidth => 15.w;
  static double get dotRadius => 12.r;

  // ─── TextField ────────────────────────────────────────────
  static double get textFieldHeight => 56.h;
  static double get textFieldRadius => 12.r;

  // ─── AppBar ───────────────────────────────────────────────
  static double get appBarHeight => 56.h;

  // ─── Card ─────────────────────────────────────────────────
  static double get cardRadius => 16.r;
  static double get cardPadding => 16.w;
  static double get cardElevation => 0;

  // ─── Avatar ───────────────────────────────────────────────
  static double get avatarSm => 32.w;
  static double get avatarMd => 48.w;
  static double get avatarLg => 64.w;
  static double get avatarXl => 96.w;

  // ─── Page Padding ─────────────────────────────────────────
  static double get pagePadding => 24.w;
  static double get pageVerticalPadding => 24.h;

  // ─── Bottom Nav ───────────────────────────────────────────
  static double get bottomNavHeight => 70.h;
}
