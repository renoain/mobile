import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/secondary_button.dart';
import '../../../../shared/widgets/section_header.dart';

/// Halaman bantuan (route /help).
///
/// Berisi search bar, daftar FAQ yang bisa diperluas, dan
/// section "Hubungi Kami" dengan tombol WhatsApp dan Email.
class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final Set<int> _expandedIndexes = {};
  String _searchQuery = '';

  static const List<_FaqItem> _faqs = [
    _FaqItem(
      question: 'Bagaimana cara memesan layanan?',
      answer:
          'Pilih layanan di halaman utama, tentukan jadwal dan alamat, '
          'lalu konfirmasi pesanan. Setelah itu, petugas akan dihubungi '
          'untuk menjadwalkan kunjungan.',
    ),
    _FaqItem(
      question: 'Bagaimana cara membayar?',
      answer:
          'Pilih metode pembayaran Transfer Bank atau COD. Jika Transfer '
          'Bank, lakukan pembayaran ke rekening kami dan upload bukti '
          'pembayaran.',
    ),
    _FaqItem(
      question: 'Bisa batalkan pesanan?',
      answer:
          'Pesanan bisa dibatalkan selama masih berstatus aktif sebelum '
          'petugas datang. Buka Detail Pesanan dan tekan tombol Batalkan '
          'Pesanan.',
    ),
    _FaqItem(
      question: 'Bagaimana cara menghubungi petugas?',
      answer:
          'Setelah petugas ditugaskan, kamu bisa menghubunginya melalui '
          'fitur Chat atau Telepon di halaman Detail Pesanan.',
    ),
    _FaqItem(
      question: 'Apakah ada jaminan kepuasan?',
      answer:
          'Ya, jika kamu tidak puas dengan hasil pekerjaan petugas, '
          'hubungi kami melalui WhatsApp atau email dan kami akan '
          'menyelesaikannya.',
    ),
  ];

  List<_FaqItem> get _filteredFaqs {
    if (_searchQuery.isEmpty) {
      return _faqs;
    }
    return _faqs
        .where(
          (faq) =>
              faq.question.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  ) ||
              faq.answer.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Bantuan'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(title: 'Pertanyaan Umum'),
              const SizedBox(height: AppSpacing.sm),
              _buildFaqList(),
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(title: 'Hubungi Kami'),
              const SizedBox(height: AppSpacing.md),
              _buildContactButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
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
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              style: AppTextStyles.body,
              decoration: InputDecoration.collapsed(
                hintText: 'Cari pertanyaan',
                hintStyle: AppTextStyles.body.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqList() {
    final faqs = _filteredFaqs;
    if (faqs.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: AppColors.border),
        ),
        child: Text(
          'Tidak ditemukan pertanyaan yang sesuai',
          style: AppTextStyles.bodySecondary,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Column(
      children: [
        for (var i = 0; i < faqs.length; i++)
          _FaqTile(
            faq: faqs[i],
            isExpanded: _expandedIndexes.contains(i),
            onTap: () {
              setState(() {
                if (_expandedIndexes.contains(i)) {
                  _expandedIndexes.remove(i);
                } else {
                  _expandedIndexes.add(i);
                }
              });
            },
          ),
      ],
    );
  }

  Widget _buildContactButtons() {
    return Row(
      children: [
        Expanded(
          child: SecondaryButton(
            label: 'WhatsApp',
            icon: AppIcons.chat,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('WhatsApp belum tersedia (mock)')),
              );
            },
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: SecondaryButton(
            label: 'Email',
            icon: AppIcons.email,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Email belum tersedia (mock)')),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FaqItem {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});
}

class _FaqTile extends StatelessWidget {
  final _FaqItem faq;
  final bool isExpanded;
  final VoidCallback onTap;

  const _FaqTile({
    required this.faq,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(faq.question, style: AppTextStyles.body),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(
                    isExpanded
                        ? AppIcons.expandUp
                        : AppIcons.expandDown,
                    size: AppSpacing.iconMd,
                    color: AppColors.textTertiary,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            const Divider(height: 1, color: AppColors.border),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text(faq.answer, style: AppTextStyles.bodySecondary),
            ),
          ],
        ],
      ),
    );
  }
}