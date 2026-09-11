import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../service/presentation/data/mock_services.dart';
import '../data/booking_draft.dart';
import 'booking_confirm_page.dart';

/// Halaman form pemesanan (route /booking/:serviceId).
///
/// Dua langkah: step 1 (jadwal dan alamat), step 2 (detail kamar).
/// Setelah lengkap, membuka BookingConfirmPage.
class BookingFormPage extends StatefulWidget {
  final Service service;

  const BookingFormPage({super.key, required this.service});

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  static const List<String> _roomSizes = [
    'Kamar kecil (sampai 3x3 m)',
    'Kamar sedang (3x3 - 3x4 m)',
    'Kamar besar (3x4 - 4x5 m)',
    'Kamar sangat besar (di atas 4x5 m)',
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _addressNoteController = TextEditingController();
  final TextEditingController _extraNoteController = TextEditingController();

  int _step = 1;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _roomSize;

  bool get _isFirstStep => _step == 1;

  @override
  void dispose() {
    _addressController.dispose();
    _addressNoteController.dispose();
    _extraNoteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _handlePrimaryAction() {
    if (_isFirstStep) {
      _advanceToDetail();
    } else {
      _confirm();
    }
  }

  void _advanceToDetail() {
    final date = _selectedDate;
    final time = _selectedTime;
    if (date == null || time == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih tanggal dan jam terlebih dahulu')),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _step = 2;
    });
  }

  void _confirm() {
    if (_roomSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih ukuran kamar terlebih dahulu')),
      );
      return;
    }
    final draft = BookingDraft(
      service: widget.service,
      date: _selectedDate!,
      time: _selectedTime!,
      address: _addressController.text.trim(),
      addressNote: _addressNoteController.text.trim(),
      roomSize: _roomSize!,
      extraNote: _extraNoteController.text.trim(),
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookingConfirmPage(draft: draft),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Pesan Layanan'),
      body: SafeArea(
        child: Column(
          children: [
            _buildStepIndicator(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: _isFirstStep ? _buildStepOne() : _buildStepTwo(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          _StepDot(
            number: 1,
            label: 'Jadwal & Alamat',
            isActive: _isFirstStep,
            isDone: !_isFirstStep,
          ),
          Expanded(
            child: Container(
              height: 2,
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              color: !_isFirstStep ? AppColors.primary : AppColors.border,
            ),
          ),
          _StepDot(
            number: 2,
            label: 'Detail Kamar',
            isActive: !_isFirstStep,
          ),
        ],
      ),
    );
  }

  Widget _buildStepOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Jadwal'),
        const SizedBox(height: AppSpacing.sm),
        _PickerField(
          label: 'Tanggal',
          value: _selectedDate != null
              ? DateFormatter.dateLabel(_selectedDate!)
              : null,
          hint: 'Pilih tanggal',
          icon: AppIcons.calendar,
          onTap: _pickDate,
        ),
        const SizedBox(height: AppSpacing.md),
        _PickerField(
          label: 'Jam',
          value: _selectedTime != null
              ? DateFormatter.timeLabel(_selectedTime!)
              : null,
          hint: 'Pilih jam',
          icon: AppIcons.schedule,
          onTap: _pickTime,
        ),
        const SizedBox(height: AppSpacing.lg),
        const SectionHeader(title: 'Alamat'),
        const SizedBox(height: AppSpacing.sm),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                label: 'Alamat Lengkap',
                hint: 'Contoh: Jl. Kenanga No. 12, Blok C',
                controller: _addressController,
                validator: _validateRequired,
              ),
              const SizedBox(height: AppSpacing.md),
              CustomTextField(
                label: 'Catatan Alamat (opsional)',
                hint: 'Patokan atau info tambahan',
                controller: _addressNoteController,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Detail Kamar'),
        const SizedBox(height: AppSpacing.sm),
        DropdownButtonFormField<String>(
          initialValue: _roomSize,
          items: [
            for (final size in _roomSizes)
              DropdownMenuItem(value: size, child: Text(size)),
          ],
          onChanged: (value) {
            setState(() {
              _roomSize = value;
            });
          },
          decoration: const InputDecoration(hintText: 'Pilih ukuran kamar'),
        ),
        const SizedBox(height: AppSpacing.md),
        CustomTextField(
          label: 'Catatan Tambahan (opsional)',
          hint: 'Kebutuhan khusus untuk petugas',
          controller: _extraNoteController,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: PrimaryButton(
            label: _isFirstStep ? 'Lanjut' : 'Konfirmasi',
            onPressed: _handlePrimaryAction,
          ),
        ),
      ),
    );
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Wajib diisi';
    }
    return null;
  }
}

class _PickerField extends StatelessWidget {
  final String label;
  final String? value;
  final String hint;
  final IconData icon;
  final VoidCallback onTap;

  const _PickerField({
    required this.label,
    required this.value,
    required this.hint,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: AppSpacing.sm),
        GestureDetector(
          onTap: onTap,
          child: Container(
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
                Expanded(
                  child: Text(
                    value ?? hint,
                    style: AppTextStyles.body.copyWith(
                      color: value != null
                          ? AppColors.textPrimary
                          : AppColors.textTertiary,
                    ),
                  ),
                ),
                Icon(icon, size: AppSpacing.iconMd, color: AppColors.textTertiary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StepDot extends StatelessWidget {
  final int number;
  final String label;
  final bool isActive;
  final bool isDone;

  const _StepDot({
    required this.number,
    required this.label,
    required this.isActive,
    this.isDone = false,
  });

  @override
  Widget build(BuildContext context) {
    final isHighlighted = isActive || isDone;
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: AppSpacing.iconXl,
          height: AppSpacing.iconXl,
          decoration: BoxDecoration(
            color: isHighlighted ? AppColors.primary : AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(
              color: isHighlighted ? AppColors.primary : AppColors.border,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            '$number',
            style: AppTextStyles.label.copyWith(
              color: isHighlighted
                  ? AppColors.textOnPrimary
                  : AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: isActive ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}