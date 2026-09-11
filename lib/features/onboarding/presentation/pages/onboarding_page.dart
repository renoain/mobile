import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../home/presentation/pages/home_page.dart';

/// Halaman onboarding (route /onboarding).
///
/// Menampilkan 3 slide (PageView) berisi ilustrasi bergradient, judul,
/// dan deskripsi, indicator dots di bawah, serta tombol Lanjut (halaman
/// bukan terakhir) atau Mulai (halaman terakhir).
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<_OnboardingItem> _items = [
    _OnboardingItem(
      icon: AppIcons.cleaning,
      title: 'Bersih Kos Tanpa Ribet',
      description:
          'Pesan jasa cleaning sesuai kebutuhanmu, dari basic hingga deep cleaning.',
    ),
    _OnboardingItem(
      icon: AppIcons.organizing,
      title: 'Rapi dan Terorganisir',
      description:
          'Jasa penataan kos untuk lemari, pakaian, dan barang-barangmu.',
    ),
    _OnboardingItem(
      icon: AppIcons.moving,
      title: 'Pindahan Jadi Mudah',
      description:
          'Packing dan pindahan kos dengan bantuan penyedia jasa terpercaya.',
    ),
  ];

  bool get _isLastPage => _currentPage == _items.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_isLastPage) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _skipToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _items.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _OnboardingSlide(item: _items[index]);
                  },
                ),
              ),
              _buildDotsIndicator(),
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(
                label: _isLastPage ? 'Mulai' : 'Lanjut',
                onPressed: _handleNext,
              ),
              if (_isLastPage) ...[
                const SizedBox(height: AppSpacing.sm),
                TextButton(
                  onPressed: _skipToHome,
                  child: Text(
                    'Lewati, Masuk sebagai Tamu',
                    style: AppTextStyles.bodySecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_items.length, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          width: isActive ? AppSpacing.lg : AppSpacing.sm,
          height: AppSpacing.sm,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.textTertiary,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
        );
      }),
    );
  }
}

class _OnboardingItem {
  final IconData icon;
  final String title;
  final String description;

  const _OnboardingItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _OnboardingSlide extends StatelessWidget {
  final _OnboardingItem item;

  const _OnboardingSlide({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Container(
          height: 260,
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primaryDark],
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowMedium,
                blurRadius: AppSpacing.shadowBlurMedium,
                offset: Offset(0, AppSpacing.shadowOffsetY),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: -40,
                right: -32,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: AppColors.textOnPrimary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: -24,
                left: -24,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.textOnPrimary.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    color: AppColors.textOnPrimary,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusFull,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadowMedium,
                        blurRadius: AppSpacing.shadowBlurSoft,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    item.icon,
                    size: AppSpacing.iconXl,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          item.title,
          style: AppTextStyles.h1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          item.description,
          style: AppTextStyles.bodySecondary,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}