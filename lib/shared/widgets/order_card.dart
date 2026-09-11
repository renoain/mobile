import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';

/// Card ringkasan pesanan dalam list.
///
/// Contoh penggunaan:
/// ```dart
/// OrderCard(
///   icon: AppIcons.cleaning,
///   title: 'Basic Cleaning Kamar',
///   subtitle: 'Senin, 15 Sep 2026',
///   status: 'Aktif',
///   statusColor: AppColors.primary,
///   onTap: () {},
/// )
/// ```
class OrderCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;
  final Color statusColor;
  final Color statusBackground;
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    this.statusColor = AppColors.primary,
    this.statusBackground = AppColors.primaryLight,
    this.onTap,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap == null ? null : (_) => _setPressed(true),
      onTapUp: widget.onTap == null ? null : (_) => _setPressed(false),
      onTapCancel: widget.onTap == null ? null : () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: AppColors.border),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowSoft,
                blurRadius: AppSpacing.shadowBlurSoft,
                offset: Offset(0, AppSpacing.shadowOffsetY),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(
                    AppSpacing.radiusMd,
                  ),
                ),
                child: Icon(
                  widget.icon,
                  size: AppSpacing.iconLg,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: AppTextStyles.h3),
                    const SizedBox(height: AppSpacing.xs),
                    Text(widget.subtitle, style: AppTextStyles.caption),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: widget.statusBackground,
                  borderRadius: BorderRadius.circular(
                    AppSpacing.radiusSm,
                  ),
                ),
                child: Text(
                  widget.status,
                  style: AppTextStyles.caption.copyWith(
                    color: widget.statusColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setPressed(bool value) {
    if (_pressed != value) {
      setState(() {
        _pressed = value;
      });
    }
  }
}