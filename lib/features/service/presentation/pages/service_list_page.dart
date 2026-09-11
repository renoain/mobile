import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/service_card.dart';
import '../data/mock_services.dart';
import 'service_detail_page.dart';

/// Halaman daftar semua layanan (route /services).
///
/// Menampilkan filter chip kategori (Semua, Cleaning, Penataan, Pindahan)
/// dan daftar ServiceCard vertikal.
class ServiceListPage extends StatefulWidget {
  const ServiceListPage({super.key});

  @override
  State<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  ServiceCategory? _selectedCategory;

  List<Service> get _filteredServices {
    final category = _selectedCategory;
    if (category == null) {
      return MockServices.all;
    }
    return MockServices.all
        .where((service) => service.category == category)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Semua Layanan'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterChips(),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                itemCount: _filteredServices.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final service = _filteredServices[index];
                  return ServiceCard(
                    icon: service.icon,
                    title: service.name,
                    description: service.description,
                    price: service.price,
                    onTap: () => _openDetail(service),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filter = _selectedCategory;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        0,
      ),
      child: Row(
        children: [
          _FilterChip(
            label: 'Semua',
            isSelected: filter == null,
            onTap: () {
              setState(() {
                _selectedCategory = null;
              });
            },
          ),
          const SizedBox(width: AppSpacing.sm),
          for (final category in ServiceCategory.values) ...[
            _FilterChip(
              label: _categoryLabel(category),
              isSelected: filter == category,
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
        ],
      ),
    );
  }

  String _categoryLabel(ServiceCategory category) {
    switch (category) {
      case ServiceCategory.cleaning:
        return 'Cleaning';
      case ServiceCategory.organizing:
        return 'Penataan';
      case ServiceCategory.moving:
        return 'Pindahan';
    }
  }

  void _openDetail(Service service) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ServiceDetailPage(service: service),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      backgroundColor: AppColors.surface,
      selectedColor: AppColors.primaryLight,
      showCheckmark: false,
      avatar: isSelected
          ? const SizedBox.shrink()
          : null,
      labelStyle: AppTextStyles.label.copyWith(
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
    );
  }
}