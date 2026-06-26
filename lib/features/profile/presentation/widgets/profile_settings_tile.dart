import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_mentor_app/core/extensions/extensions.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';

class ProfileSettingsTile extends StatelessWidget {
  const ProfileSettingsTile({
    super.key,
    required this.svgAsset,
    required this.label,
    required this.onTap,
    this.labelColor,
    this.isDestructive = false,
  });

  final String svgAsset;
  final String label;
  final VoidCallback onTap;
  final Color? labelColor;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final iconColor =
        isDestructive ? context.errorColor : context.textSecondaryColor;
    final textColor = labelColor ?? context.textPrimaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.vsm,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.chevron_left,
              size: 20.r,
              color: context.textSecondaryColor,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.sm),
                child: Text(
                  label,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.bodyRegular(color: textColor),
                ),
              ),
            ),
            Container(
              width: 36.r,
              height: 36.r,
              decoration: BoxDecoration(
                color: isDestructive
                    ? context.errorColor.withOpacity(0.1)
                    : context.skyBlueColor,
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: Center(
                child: SvgPicture.asset(
                  svgAsset,
                  width: 18.r,
                  height: 18.r,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
