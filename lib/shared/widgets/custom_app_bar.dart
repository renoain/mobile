import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';

/// AppBar kustom dengan title center dan opsi back button.
///
/// Contoh penggunaan:
/// ```dart
/// CustomAppBar(title: 'Detail Pesanan')
/// ```
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.onBackPressed,
  });

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + 1);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.h3.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              onPressed: onBackPressed ??
                  () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: AppSpacing.iconMd,
                color: AppColors.textPrimary,
              ),
            )
          : null,
      actions: actions,
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: AppSpacing.elevationNone,
      scrolledUnderElevation: AppSpacing.elevationLow,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: AppColors.border,
        ),
      ),
    );
  }
}