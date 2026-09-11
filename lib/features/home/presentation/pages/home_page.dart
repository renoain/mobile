import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/order_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/service_card.dart';
import '../../../auth/data/auth_state.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../order/presentation/data/mock_orders.dart';
import '../../../order/presentation/data/order_status_style.dart';
import '../../../order/presentation/pages/order_detail_page.dart';
import '../../../order/presentation/pages/order_list_page.dart';
import '../../../profile/presentation/data/mock_user.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../service/presentation/data/mock_services.dart';
import '../../../service/presentation/pages/service_detail_page.dart';
import '../../../service/presentation/pages/service_list_page.dart';

/// Halaman utama (route /home).
///
/// Menampilkan hero greeting, search bar, grid layanan, daftar pesanan aktif,
/// dan bottom navigation kustom (Beranda, Pesanan, Profil). Data masih mock.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<String> _titles = ['KKOS', 'Pesanan Saya', 'Profil'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          if (_selectedIndex == 0)
            IconButton(
              onPressed: () {},
              icon: const Icon(
                AppIcons.notifications,
                size: AppSpacing.iconMd,
                color: AppColors.textPrimary,
              ),
            ),
        ],
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: AppSpacing.elevationNone,
        scrolledUnderElevation: AppSpacing.elevationLow,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.border),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(),
          const OrderListPage(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          AppBottomNavDestination(icon: AppIcons.home, label: 'Beranda'),
          AppBottomNavDestination(icon: AppIcons.orders, label: 'Pesanan'),
          AppBottomNavDestination(icon: AppIcons.profile, label: 'Profil'),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (AuthState().isGuest) ...[
              _buildGuestBanner(),
              const SizedBox(height: AppSpacing.md),
            ],
            _buildHero(),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(
              title: 'Layanan Kami',
              actionLabel: 'Lihat Semua',
              onActionTap: _openServiceList,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildServiceGrid(),
            if (AuthState().isLoggedIn) ...[
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(title: 'Pesanan Aktif'),
              const SizedBox(height: AppSpacing.md),
              _buildOrderList(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.xs,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
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
              AuthState().isGuest
                  ? 'Halo, Tamu'
                  : 'Halo, ${MockUser.name}',
              style: AppTextStyles.h1.copyWith(
                color: AppColors.textOnPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Ada yang bisa kami bantu hari ini?',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textOnPrimary.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            GestureDetector(
              onTap: _openServiceList,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
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
                    const Icon(
                      AppIcons.search,
                      size: AppSpacing.iconMd,
                      color: AppColors.textTertiary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Cari layanan',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuestBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(
            AppIcons.info,
            size: AppSpacing.iconMd,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Kamu masuk sebagai tamu. Login untuk memesan layanan.',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primaryDark,
              ),
            ),
          ),
          TextButton(
            onPressed: _openLogin,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              textStyle: AppTextStyles.label.copyWith(
                fontWeight: FontWeight.w700,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Masuk'),
          ),
        ],
      ),
    );
  }

  void _openLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Widget _buildServiceGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.88,
      ),
      itemCount: MockServices.all.length,
      itemBuilder: (context, index) {
        final service = MockServices.all[index];
        return ServiceCard(
          icon: service.icon,
          title: service.name,
          description: service.description,
          price: service.price,
          onTap: () => _openServiceDetail(service),
        );
      },
    );
  }

  Widget _buildOrderList() {
    final activeOrders = MockOrders.all
        .where((order) => order.status == OrderStatus.active)
        .toList();
    if (activeOrders.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Text(
          'Tidak ada pesanan aktif',
          style: AppTextStyles.bodySecondary,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        children: [
          for (final order in activeOrders) ...[
            OrderCard(
              icon: order.icon,
              title: order.title,
              subtitle: order.schedule,
              status: order.statusLabel,
              statusColor: order.status.color,
              statusBackground: order.status.background,
              onTap: () => _openOrderDetail(order),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }

  void _openServiceList() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ServiceListPage()),
    );
  }

  void _openServiceDetail(Service service) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ServiceDetailPage(service: service),
      ),
    );
  }

  void _openOrderDetail(Order order) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OrderDetailPage(order: order),
      ),
    );
  }
}