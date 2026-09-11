import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/info_card.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/secondary_button.dart';
import '../data/mock_orders.dart';

/// Halaman detail pesanan (route /orders/:id).
///
/// Menampilkan tracker status (timeline), info layanan, petugas,
/// jadwal dan alamat, rincian harga, aksi Chat/Telepon, dan tombol
/// batalkan bila pesanan masih aktif.
class OrderDetailPage extends StatelessWidget {
  final Order order;

  const OrderDetailPage({
    super.key,
    required this.order,
  });

  static const List<String> _statusSteps = [
    'Pesanan',
    'Dijadwalkan',
    'Dikerjakan',
    'Selesai',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Detail Pesanan'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              if (order.status != OrderStatus.cancelled)
                _buildTimeline()
              else
                _buildCancelledNotice(),
              const SizedBox(height: AppSpacing.lg),
              InfoCard(
                title: 'Layanan',
                child: _buildService(),
              ),
              if (order.cleanerName != null) ...[
                const SizedBox(height: AppSpacing.md),
                InfoCard(
                  title: 'Petugas',
                  child: _buildCleaner(),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              InfoCard(
                title: 'Jadwal dan Alamat',
                child: _buildScheduleAddress(),
              ),
              const SizedBox(height: AppSpacing.md),
              InfoCard(
                title: 'Rincian Harga',
                child: _buildPrice(),
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildActions(context),
              if (order.status == OrderStatus.active) ...[
                const SizedBox(height: AppSpacing.md),
                PrimaryButton(
                  label: 'Batalkan Pesanan',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pesanan dibatalkan (mock)')),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    final isCompleted = order.status == OrderStatus.completed;
    final completedCount = isCompleted ? _statusSteps.length : 3;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < _statusSteps.length; i++) ...[
              _buildTimelineNode(i, completedCount, isActive: !isCompleted),
              if (i < _statusSteps.length - 1)
                _buildTimelineLine(i, completedCount),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineNode(
    int index,
    int completedCount, {
    required bool isActive,
  }) {
    final isDone = index < completedCount - 1;
    final isCurrent = isActive && index == completedCount - 1;
    final isHighlighted = isDone || isCurrent;
    return Expanded(
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: AppSpacing.iconXl,
            height: AppSpacing.iconXl,
            decoration: BoxDecoration(
              color: isHighlighted ? AppColors.primary : AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: isHighlighted ? AppColors.primary : AppColors.border,
              ),
              boxShadow: isHighlighted
                  ? const [
                      BoxShadow(
                        color: AppColors.shadowMedium,
                        blurRadius: AppSpacing.shadowBlurSoft,
                        offset: Offset(0, AppSpacing.shadowOffsetY),
                      ),
                    ]
                  : null,
            ),
            child: isDone
                ? const Icon(
                    AppIcons.close,
                    size: AppSpacing.iconSm,
                    color: AppColors.textOnPrimary,
                  )
                : null,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            _statusSteps[index],
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              color: isHighlighted
                  ? AppColors.primary
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineLine(int index, int completedCount) {
    final isDone = index + 1 < completedCount;
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(top: AppSpacing.md - 1),
        color: isDone ? AppColors.primary : AppColors.border,
      ),
    );
  }

  Widget _buildCancelledNotice() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: const Icon(
              AppIcons.close,
              size: AppSpacing.iconSm,
              color: AppColors.error,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              'Pesanan ini telah dibatalkan',
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildService() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: Icon(
            order.icon,
            size: AppSpacing.iconLg,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(order.title, style: AppTextStyles.h3),
              const SizedBox(height: AppSpacing.xs),
              Text(
                PriceFormatter.rupiah(order.total),
                style: AppTextStyles.body.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCleaner() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
          child: const Icon(
            AppIcons.profile,
            size: AppSpacing.iconLg,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(order.cleanerName!, style: AppTextStyles.h3),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  const Icon(
                    AppIcons.star,
                    size: AppSpacing.iconSm,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    order.cleanerRating!.toStringAsFixed(1),
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _IconTextRow(icon: AppIcons.calendar, text: order.schedule),
        const SizedBox(height: AppSpacing.sm),
        _IconTextRow(icon: AppIcons.location, text: order.address),
        const SizedBox(height: AppSpacing.sm),
        _IconTextRow(icon: AppIcons.home, text: order.roomSize),
      ],
    );
  }

  Widget _buildPrice() {
    return Column(
      children: [
        _PriceRow(
          label: 'Harga layanan',
          value: PriceFormatter.rupiah(order.basePrice),
        ),
        const SizedBox(height: AppSpacing.sm),
        _PriceRow(
          label: 'Biaya layanan (10%)',
          value: PriceFormatter.rupiah(order.serviceFee),
        ),
        const SizedBox(height: AppSpacing.md),
        const Divider(color: AppColors.border),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total', style: AppTextStyles.h3),
            Text(
              PriceFormatter.rupiah(order.total),
              style: AppTextStyles.h3.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SecondaryButton(
            label: 'Chat',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur chat sedang dikembangkan')),
              );
            },
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: SecondaryButton(
            label: 'Telepon',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur panggilan sedang dikembangkan')),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _IconTextRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _IconTextRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Icon(icon, size: AppSpacing.iconSm, color: AppColors.primary),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(text, style: AppTextStyles.body),
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;

  const _PriceRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodySecondary),
        Text(value, style: AppTextStyles.body),
      ],
    );
  }
}