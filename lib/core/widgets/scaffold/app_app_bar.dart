import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../extensions/extensions.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final bool showBack;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final VoidCallback? onBack;
  final bool centerTitle;

  const AppAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.showBack = true,
    this.actions,
    this.backgroundColor,
    this.onBack,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? context.surfaceColor;
    final textColor = context.textPrimaryColor;

    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      leading:
          showBack
              ? GestureDetector(
                onTap: onBack ?? () => context.pop(),
                child: Container(
                  margin: EdgeInsets.all(AppSizes.sm),
                  decoration: BoxDecoration(
                    color: context.surfaceVariantColor,
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: textColor,
                    size: AppSizes.iconSm,
                  ),
                ),
              )
              : null,
      title:
          titleWidget ??
          (title != null
              ? Text(title!, style: AppTextStyles.headingS(color: textColor))
              : null),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppSizes.appBarHeight);
}
