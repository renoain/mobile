import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/price_formatter.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../booking/presentation/data/booking_draft.dart';

/// Halaman pembayaran (route /payment/:orderId).
///
/// Menampilkan total pembayaran, pilihan metode (Transfer Bank / COD),
/// info rekening tujuan bila transfer, dan tombol Upload Bukti Bayar.
class PaymentPage extends StatefulWidget {
  final BookingDraft draft;

  const PaymentPage({
    super.key,
    required this.draft,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

enum _PaymentMethod { bankTransfer, cod }

class _PaymentPageState extends State<PaymentPage> {
  _PaymentMethod _method = _PaymentMethod.bankTransfer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Pembayaran'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTotalCard(),
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(title: 'Metode Pembayaran'),
              const SizedBox(height: AppSpacing.sm),
              _buildBankOption(),
              _buildCodOption(),
              if (_method == _PaymentMethod.bankTransfer) ...[
                const SizedBox(height: AppSpacing.lg),
                const SectionHeader(title: 'Info Rekening Tujuan'),
                const SizedBox(height: AppSpacing.sm),
                _buildBankInfo(),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildTotalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: AppSpacing.shadowBlurMedium,
            offset: Offset(0, AppSpacing.shadowOffsetY),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Pembayaran',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textOnPrimary.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.draft.service.name,
            style: AppTextStyles.bodySecondary.copyWith(
              color: AppColors.textOnPrimary.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            PriceFormatter.rupiah(widget.draft.total),
            style: AppTextStyles.h1.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankOption() {
    return _MethodOption(
      method: _PaymentMethod.bankTransfer,
      selectedMethod: _method,
      icon: AppIcons.bank,
      title: 'Transfer Bank',
      subtitle: 'Transfer ke rekening kami',
      onChanged: _selectMethod,
    );
  }

  Widget _buildCodOption() {
    return _MethodOption(
      method: _PaymentMethod.cod,
      selectedMethod: _method,
      icon: AppIcons.cash,
      title: 'COD',
      subtitle: 'Bayar langsung saat petugas tiba',
      onChanged: _selectMethod,
    );
  }

  void _selectMethod(_PaymentMethod method) {
    setState(() {
      _method = method;
    });
  }

  Widget _buildBankInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: const Icon(
                  AppIcons.bank,
                  size: AppSpacing.iconLg,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bank BCA', style: AppTextStyles.body),
                    Text(
                      '1234567890',
                      style: AppTextStyles.h3,
                    ),
                    Text(
                      'a.n. PT Kost Care Indonesia',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Nomor rekening hanya untuk verifikasi pembayaran pesananmu.',
            style: AppTextStyles.caption,
          ),
        ],
      ),
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
            label: _method == _PaymentMethod.bankTransfer
                ? 'Upload Bukti Bayar'
                : 'Lanjut ke Pembayaran',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fitur upload bukti sedang dikembangkan'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MethodOption extends StatelessWidget {
  final _PaymentMethod method;
  final _PaymentMethod selectedMethod;
  final IconData icon;
  final String title;
  final String subtitle;
  final ValueChanged<_PaymentMethod> onChanged;

  const _MethodOption({
    required this.method,
    required this.selectedMethod,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = method == selectedMethod;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: RadioGroup<_PaymentMethod>(
          groupValue: selectedMethod,
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
          child: RadioListTile<_PaymentMethod>(
            value: method,
            activeColor: AppColors.primary,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            secondary: Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryLight
                    : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(
                icon,
                size: AppSpacing.iconLg,
                color: isSelected
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
            ),
            title: Text(
              title,
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}