import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../data/mock_user.dart';

/// Halaman edit profil (route /profile/edit).
///
/// Berisi avatar dengan tombol edit, field nama, email (disabled),
/// nomor HP, dan tombol Simpan.
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: MockUser.name);
    _phoneController = TextEditingController(text: MockUser.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil berhasil disimpan (mock)')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Edit Profil'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              _buildAvatar(),
              const SizedBox(height: AppSpacing.lg),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      label: 'Nama Lengkap',
                      controller: _nameController,
                      validator: _validateRequired,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    CustomTextField(
                      label: 'Email',
                      controller: TextEditingController(text: MockUser.email),
                      enabled: false,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    CustomTextField(
                      label: 'Nomor HP',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: _validateRequired,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    PrimaryButton(
                      label: 'Simpan',
                      onPressed: _handleSave,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 96,
          height: 96,
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
        Positioned(
          bottom: 0,
          right: AppSpacing.xs,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.xs + 2),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surface, width: 2),
            ),
            child: const Icon(
              AppIcons.edit,
              size: AppSpacing.iconSm,
              color: AppColors.textOnPrimary,
            ),
          ),
        ),
      ],
    );
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Wajib diisi';
    }
    return null;
  }
}