import 'package:flutter/material.dart';
import '../../extensions/extensions.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';
import '../buttons/app_button.dart';

// ─── Base Empty Widget ────────────────────────────────────────────────────────
class AppEmptyWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final String? buttonLabel;
  final VoidCallback? onAction;
  final IconData icon;
  final Color? iconColor;

  const AppEmptyWidget({
    super.key,
    this.title,
    this.message,
    this.buttonLabel,
    this.onAction,
    this.icon = Icons.inbox_outlined,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppSizes.iconXxl,
              color: iconColor ?? AppColors.grey400,
            ),
            SizedBox(height: AppSizes.vlg),
            Text(
              title ?? context.tr.emptyGeneral,
              style: AppTextStyles.headingS(color: context.textPrimaryColor),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              SizedBox(height: AppSizes.vsm),
              Text(
                message!,
                style: AppTextStyles.bodyM(color: context.textSecondaryColor),
                textAlign: TextAlign.center,
              ),
            ],
            if (onAction != null) ...[
              SizedBox(height: AppSizes.vxxl),
              AppButton(
                label: buttonLabel ?? context.tr.retry,
                onTap: onAction,
                isFullWidth: false,
                width: 180,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Empty List ───────────────────────────────────────────────────────────────
class AppEmptyListWidget extends StatelessWidget {
  final VoidCallback? onAction;
  final String? actionLabel;

  const AppEmptyListWidget({super.key, this.onAction, this.actionLabel});

  @override
  Widget build(BuildContext context) {
    return AppEmptyWidget(
      title: context.tr.emptyList,
      icon: Icons.list_alt_rounded,
      onAction: onAction,
      buttonLabel: actionLabel,
    );
  }
}

// ─── Empty Search ─────────────────────────────────────────────────────────────
class AppEmptySearchWidget extends StatelessWidget {
  const AppEmptySearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppEmptyWidget(
      title: context.tr.emptySearch,
      icon: Icons.search_rounded,
      iconColor: AppColors.primary.withOpacity(0.5),
    );
  }
}

// ─── Empty Notifications ──────────────────────────────────────────────────────
class AppEmptyNotificationsWidget extends StatelessWidget {
  const AppEmptyNotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppEmptyWidget(
      title: context.tr.emptyNotifications,
      icon: Icons.notifications_none_rounded,
      iconColor: AppColors.primary.withOpacity(0.5),
    );
  }
}

// ─── Empty Favorites ──────────────────────────────────────────────────────────
class AppEmptyFavoritesWidget extends StatelessWidget {
  const AppEmptyFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppEmptyWidget(
      title: context.tr.emptyFavorites,
      icon: Icons.favorite_border_rounded,
      //iconColor: AppColors.accent.withOpacity(0.5),
    );
  }
}

// ─── Empty Mentors ────────────────────────────────────────────────────────────
class AppEmptyMentorsWidget extends StatelessWidget {
  final VoidCallback? onRefresh;

  const AppEmptyMentorsWidget({super.key, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return AppEmptyWidget(
      title: context.tr.emptyMentors,
      icon: Icons.people_outline_rounded,
      // iconColor: AppColors.secondary.withOpacity(0.5),
      onAction: onRefresh,
      buttonLabel: context.tr.retry,
    );
  }
}

// ─── Empty Sessions ───────────────────────────────────────────────────────────
class AppEmptySessionsWidget extends StatelessWidget {
  final VoidCallback? onBook;

  const AppEmptySessionsWidget({super.key, this.onBook});

  @override
  Widget build(BuildContext context) {
    return AppEmptyWidget(
      title: context.tr.emptySessions,
      icon: Icons.calendar_today_outlined,
      iconColor: AppColors.primary.withOpacity(0.5),
      onAction: onBook,
    );
  }
}
