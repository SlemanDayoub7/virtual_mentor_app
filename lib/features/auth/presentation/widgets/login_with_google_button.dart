import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/utils/app_assets.dart';
import 'package:virtual_mentor_app/core/widgets/buttons/app_button.dart';

class LoginWithGoogleButton extends StatelessWidget {
  final void Function()? onTap;
  final bool isLoading;
  const LoginWithGoogleButton({required this.isLoading, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: context.tr.continueWith,
      type: AppButtonType.outline,
      onTap: isLoading ? null : onTap,
      prefixWidget: SizedBox(
        width: 22.w,
        height: 22.w,
        child: SvgPicture.asset(AppAssets.google, fit: BoxFit.contain),
      ),
    );
  }
}
