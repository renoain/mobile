import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../auth/data/auth_state.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../data/mock_user.dart';
import 'edit_profile_page.dart';
import 'help_page.dart';

/// Halaman profil user (route /profile).
///
/// Menampilkan avatar, nama, dan daftar menu (Edit Profil,
/// Alamat Tersimpan, Metode Pembayaran, Notifikasi, Bantuan,
/// Tentang Aplikasi, Keluar). Saat masih guest, hanya tampil
/// opsi Masuk, Bantuan, dan Tentang Aplikasi.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  bool get _isGuest => AuthState().isGuest;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: AppSpacing.lg),
          _buildMenuSection(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.surface,
              width: 3,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowMedium,
                blurRadius: AppSpacing.shadowBlurMedium,
                offset: Offset(0, AppSpacing.shadowOffsetY),
              ),
            ],
          ),
          child: const Icon(
            AppIcons.profile,
            size: AppSpacing.iconEmptyState,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(_isGuest ? 'Tamu' : MockUser.name, style: AppTextStyles.h2),
        const SizedBox(height: AppSpacing.xs),
        Text(
          _isGuest ? 'Masuk untuk menikmati semua fitur' : MockUser.email,
          style: AppTextStyles.caption,
        ),
        if (_isGuest) ...[
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: 160,
            child: PrimaryButton(
              label: 'Masuk',
              fullWidth: true,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          if (_isGuest) ...[
            _MenuItem(
              icon: AppIcons.bank,
              label: 'Metode Pembayaran',
              onTap: _placeholder,
            ),
            const _MenuDivider(),
          ] else ...[
            _MenuItem(
              icon: AppIcons.edit,
              label: 'Edit Profil',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EditProfilePage(),
                  ),
                );
              },
            ),
            const _MenuDivider(),
            _MenuItem(
              icon: AppIcons.location,
              label: 'Alamat Tersimpan',
              onTap: _placeholder,
            ),
            const _MenuDivider(),
            _MenuItem(
              icon: AppIcons.bank,
              label: 'Metode Pembayaran',
              onTap: _placeholder,
            ),
            const _MenuDivider(),
            _MenuItem(
              icon: AppIcons.notifications,
              label: 'Notifikasi',
              onTap: _placeholder,
            ),
            const _MenuDivider(),
          ],
          _MenuItem(
            icon: AppIcons.help,
            label: 'Bantuan',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HelpPage(),
                ),
              );
            },
          ),
          const _MenuDivider(),
          _MenuItem(
            icon: AppIcons.info,
            label: 'Tentang Aplikasi',
            onTap: _placeholder,
          ),
          if (!_isGuest) ...[
            const _MenuDivider(),
            _MenuItem(
              icon: AppIcons.logout,
              label: 'Keluar',
              isDestructive: true,
              onTap: () {
                AuthState().setLoggedOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  void _placeholder() {}
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDestructive;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    this.isDestructive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.textPrimary;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Icon(icon, size: AppSpacing.iconLg, color: color),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.body.copyWith(
                    color: color,
                    fontWeight:
                        isDestructive ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
              if (!isDestructive)
                const Icon(
                  AppIcons.chevronRight,
                  size: AppSpacing.iconSm,
                  color: AppColors.textTertiary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 0.5,
      color: AppColors.divider,
    );
  }
}