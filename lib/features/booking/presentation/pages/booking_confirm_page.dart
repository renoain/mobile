import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/info_card.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../payment/presentation/pages/payment_page.dart';
import '../data/booking_draft.dart';

/// Halaman konfirmasi pemesanan (route /booking/confirm).
///
/// Menampilkan ringkasan layanan, jadwal, alamat, detail kamar,
/// dan rincian harga sebelum pesanan dikonfirmasi.
class BookingConfirmPage extends StatelessWidget {
  final BookingDraft draft;

  const BookingConfirmPage({
    super.key,
    required this.draft,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Konfirmasi Pesanan'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              InfoCard(
                title: 'Ringkasan Layanan',
                child: _buildServiceSummary(),
              ),
              const SizedBox(height: AppSpacing.md),
              InfoCard(
                title: 'Jadwal',
                child: _buildSchedule(),
              ),
              const SizedBox(height: AppSpacing.md),
              InfoCard(
                title: 'Alamat',
                child: _buildAddress(),
              ),
              const SizedBox(height: AppSpacing.md),
              InfoCard(
                title: 'Detail Kamar',
                child: _buildRoomDetail(),
              ),
              const SizedBox(height: AppSpacing.md),
              InfoCard(
                title: 'Rincian Harga',
                child: _buildPriceBreakdown(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildServiceSummary() {
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
            draft.service.icon,
            size: AppSpacing.iconLg,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(draft.service.name, style: AppTextStyles.h3),
              const SizedBox(height: AppSpacing.xs),
              Text(
                draft.service.price,
                style: AppTextStyles.body.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSchedule() {
    return Row(
      children: [
        const Icon(
          AppIcons.calendar,
          size: AppSpacing.iconLg,
          color: AppColors.textTertiary,
        ),
        const SizedBox(width: AppSpacing.md),
        Text(
          '${DateFormatter.dateLabel(draft.date)}, '
          '${DateFormatter.timeLabel(draft.time)}',
          style: AppTextStyles.body,
        ),
      ],
    );
  }

  Widget _buildAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              AppIcons.location,
              size: AppSpacing.iconLg,
              color: AppColors.textTertiary,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: Text(draft.address, style: AppTextStyles.body)),
          ],
        ),
        if (draft.addressNote != null && draft.addressNote!.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.iconLg + AppSpacing.md),
            child: Text(
              'Catatan: ${draft.addressNote}',
              style: AppTextStyles.caption,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRoomDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(draft.roomSize, style: AppTextStyles.body),
        if (draft.extraNote != null && draft.extraNote!.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Text('Catatan: ${draft.extraNote}', style: AppTextStyles.caption),
        ],
      ],
    );
  }

  Widget _buildPriceBreakdown() {
    return Column(
      children: [
        _PriceRow(
          label: 'Harga layanan',
          value: PriceFormatter.rupiah(draft.basePrice),
        ),
        const SizedBox(height: AppSpacing.sm),
        _PriceRow(
          label: 'Biaya layanan (10%)',
          value: PriceFormatter.rupiah(draft.serviceFee),
        ),
        const SizedBox(height: AppSpacing.md),
        const Divider(color: AppColors.border),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total', style: AppTextStyles.h3),
            Text(
              PriceFormatter.rupiah(draft.total),
              style: AppTextStyles.h3.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: PrimaryButton(
            label: 'Konfirmasi Pesanan',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PaymentPage(draft: draft),
                ),
              );
            },
          ),
        ),
      ),
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