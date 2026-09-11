import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../onboarding/presentation/pages/onboarding_page.dart';

/// Halaman splash (route /).
///
/// Menampilkan logo KKOS di tengah dengan animasi masuk halus dan
/// loading indicator di bawahnya. Setelah durasi singkat otomatis
/// berpindah ke OnboardingPage.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), _goToOnboarding);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _goToOnboarding() {
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const OnboardingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.92, end: 1),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutBack,
                builder: (context, scale, child) =>
                    Transform.scale(scale: scale, child: child),
                child: _buildLogo(),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Kost Care for Kost',
                style: AppTextStyles.label.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const LoadingIndicator(size: AppSpacing.iconLg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: AppColors.textOnPrimary,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: AppSpacing.shadowBlurMedium,
            offset: Offset(0, AppSpacing.shadowOffsetY),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        'KKOS',
        style: AppTextStyles.h1.copyWith(color: AppColors.textOnPrimary),
      ),
    );
  }
}