import 'package:flutter/material.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/scaffold/app_app_bar.dart';
import '../../../../core/widgets/scaffold/app_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppAppBar(title: context.tr.home, showBack: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: AppSizes.iconXxl,
              color: context.colorScheme.primary,
            ),
            SizedBox(height: AppSizes.vlg),
            Text(
              context.tr.appName,
              style: AppTextStyles.headingL(color: context.textPrimaryColor),
            ),
            SizedBox(height: AppSizes.vsm),
            Text(
              context.tr.welcomeMessage,
              style: AppTextStyles.bodyL(color: context.textSecondaryColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
