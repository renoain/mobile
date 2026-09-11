import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/order_card.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../auth/data/auth_state.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../data/mock_orders.dart';
import '../data/order_status_style.dart';
import 'order_detail_page.dart';

/// Halaman daftar pesanan (route /orders).
///
/// Menampilkan TabBar (Aktif, Selesai, Dibatalkan) dan list OrderCard
/// sesuai status terpilih.
class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (AuthState().isGuest) {
      return _buildLoginPrompt(context);
    }
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          _buildTabBar(),
          const Divider(height: 1, color: AppColors.border),
          Expanded(
            child: TabBarView(
              children: [
                _buildList(
                  context,
                  status: OrderStatus.active,
                  emptyTitle: 'Belum ada pesanan aktif',
                  emptyDescription: 'Pesan layanan pertama kali dari halaman utama',
                ),
                _buildList(
                  context,
                  status: OrderStatus.completed,
                  emptyTitle: 'Belum ada pesanan selesai',
                  emptyDescription: 'Pesanan yang selesai akan muncul di sini',
                ),
                _buildList(
                  context,
                  status: OrderStatus.cancelled,
                  emptyTitle: 'Belum ada pesanan dibatalkan',
                  emptyDescription: 'Pesanan yang dibatalkan akan muncul di sini',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return EmptyState(
      title: 'Login untuk melihat pesanan',
      description: 'Pesananmu hanya tampil setelah kamu masuk ke akun.',
      icon: AppIcons.orders,
      action: SizedBox(
        width: 200,
        child: PrimaryButton(
          label: 'Masuk',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      tabs: const [
        Tab(text: 'Aktif'),
        Tab(text: 'Selesai'),
        Tab(text: 'Dibatalkan'),
      ],
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.textTertiary,
      labelStyle: AppTextStyles.label.copyWith(fontWeight: FontWeight.w700),
      unselectedLabelStyle: AppTextStyles.label,
      indicatorColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: AppColors.border,
      labelPadding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
    );
  }

  Widget _buildList(
    BuildContext context, {
    required OrderStatus status,
    required String emptyTitle,
    required String emptyDescription,
  }) {
    final orders =
        MockOrders.all.where((order) => order.status == status).toList();
    if (orders.isEmpty) {
      return EmptyState(
        title: emptyTitle,
        description: emptyDescription,
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: orders.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCard(
          icon: order.icon,
          title: order.title,
          subtitle: order.schedule,
          status: order.statusLabel,
          statusColor: order.status.color,
          statusBackground: order.status.background,
          onTap: () => _openDetail(context, order),
        );
      },
    );
  }

  void _openDetail(BuildContext context, Order order) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OrderDetailPage(order: order),
      ),
    );
  }
}