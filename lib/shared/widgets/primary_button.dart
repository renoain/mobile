import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';

/// Tombol utama dengan background primary.
///
/// Contoh penggunaan:
/// ```dart
/// PrimaryButton(
///   label: 'Pesan Sekarang',
///   onPressed: () {},
/// )
/// ```
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool fullWidth;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = icon != null
        ? ElevatedButton.icon(
            onPressed: isLoading ? null : onPressed,
            icon: isLoading
                ? const SizedBox(
                    width: AppSpacing.iconMd,
                    height: AppSpacing.iconMd,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.textOnPrimary,
                    ),
                  )
                : Icon(icon, size: AppSpacing.iconMd),
            label: Text(label),
            style: _buttonStyle(),
          )
        : ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: _buttonStyle(),
            child: isLoading
                ? const SizedBox(
                    width: AppSpacing.iconMd,
                    height: AppSpacing.iconMd,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.textOnPrimary,
                    ),
                  )
                : Text(label),
          );

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      disabledBackgroundColor: AppColors.disabled,
      disabledForegroundColor: AppColors.disabledText,
      elevation: AppSpacing.elevationLow,
      shadowColor: AppColors.shadowMedium,
      overlayColor: AppColors.primaryDark.withValues(alpha: 0.25),
      minimumSize: const Size(0, 48),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      textStyle: AppTextStyles.button,
    );
  }
}