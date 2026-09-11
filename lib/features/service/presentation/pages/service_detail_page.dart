import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../auth/data/auth_state.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../booking/presentation/pages/booking_form_page.dart';
import '../data/mock_services.dart';

/// Halaman detail layanan (route /services/:id).
///
/// Menampilkan icon besar, nama, rating, harga, deskripsi, daftar
/// yang termasuk, durasi, dan tombol Pesan Sekarang di bottom bar.
class ServiceDetailPage extends StatelessWidget {
  final Service service;

  const ServiceDetailPage({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: service.name),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: AppSpacing.lg),
              Text(service.name, style: AppTextStyles.h1),
              const SizedBox(height: AppSpacing.sm),
              _buildRating(),
              const SizedBox(height: AppSpacing.sm),
              Text(
                service.price,
                style: AppTextStyles.h2.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Divider(color: AppColors.border),
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(title: 'Deskripsi'),
              const SizedBox(height: AppSpacing.sm),
              Text(service.description, style: AppTextStyles.body),
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(title: 'Yang Termasuk'),
              const SizedBox(height: AppSpacing.sm),
              _buildIncludes(),
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(title: 'Durasi'),
              const SizedBox(height: AppSpacing.sm),
              _buildDuration(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 200,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -32,
            top: -32,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.55),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 24,
            bottom: -40,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.35),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowMedium,
                    blurRadius: AppSpacing.shadowBlurMedium,
                    offset: Offset(0, AppSpacing.shadowOffsetY),
                  ),
                ],
              ),
              child: Icon(
                service.icon,
                size: AppSpacing.iconXl,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        const Icon(
          AppIcons.star,
          size: AppSpacing.iconMd,
          color: AppColors.warning,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          '${service.rating.toStringAsFixed(1)} (${service.reviewCount} ulasan)',
          style: AppTextStyles.bodySecondary,
        ),
      ],
    );
  }

  Widget _buildIncludes() {
    return Column(
      children: [
        for (final item in service.includes) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  AppIcons.check,
                  size: AppSpacing.iconSm,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: Text(item, style: AppTextStyles.body)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }

  Widget _buildDuration() {
    return Container(
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
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: const Icon(
              AppIcons.schedule,
              size: AppSpacing.iconSm,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(service.duration, style: AppTextStyles.body),
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
            label: 'Pesan Sekarang',
            onPressed: () => _handleBooking(context),
          ),
        ),
      ),
    );
  }

  void _handleBooking(BuildContext context) {
    if (AuthState().isGuest) {
      _showLoginDialog(context);
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookingFormPage(service: service),
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          ),
          title: Text(
            'Login Diperlukan',
            style: AppTextStyles.h3,
          ),
          content: Text(
            'Silakan login terlebih dahulu untuk memesan layanan ${service.name}.',
            style: AppTextStyles.bodySecondary,
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
                textStyle: AppTextStyles.label,
              ),
              child: const Text('Nanti Saja'),
            ),
            PrimaryButton(
              label: 'Masuk',
              fullWidth: false,
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}