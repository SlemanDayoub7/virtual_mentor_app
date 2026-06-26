import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virtual_mentor_app/core/utils/app_assets.dart';

class AuthBackgroundShapeWidget extends StatelessWidget {
  const AuthBackgroundShapeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: SvgPicture.asset(
        AppAssets.backgroundShape,
        width: 57.w,
        height: 1.sh,
        fit: BoxFit.contain,
      ),
    );
  }
}
