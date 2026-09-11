# KKOS Component Library

Dokumen ini menjelaskan setiap widget reusable yang tersedia dan cara penggunaannya. AI WAJIB menggunakan komponen ini dan DILARANG membuat versi baru yang duplikat.

## Struktur Folder

lib/shared/widgets/
primary_button.dart
secondary_button.dart
custom_app_bar.dart
custom_text_field.dart
empty_state.dart
loading_indicator.dart
service_card.dart
section_header.dart
order_card.dart
info_card.dart

## Cara Menambah Komponen Baru

Sebelum membuat komponen baru:

1. Cek apakah sudah ada komponen serupa di folder shared/widgets/
2. Jika ada, extend atau modifikasi komponen yang ada
3. Jika belum ada, buat komponen baru dengan konvensi:
   - File: snake_case.dart
   - Class: PascalCase
   - Constructor: const
   - Parameter: named, dengan default value jika memungkinkan
   - Dokumentasi: comment di atas class

Template komponen baru:

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';

/// Deskripsi singkat komponen.
///
/// Contoh penggunaan:
/// NamaKomponen(
/// parameter: value,
/// )
class NamaKomponen extends StatelessWidget {
final String parameter;

const NamaKomponen({
super.key,
required this.parameter,
});

@override
Widget build(BuildContext context) {
return Container();
}
}

## Aturan Umum Komponen

1. Semua komponen WAJIB extends StatelessWidget atau StatefulWidget
2. Constructor WAJIB const jika memungkinkan
3. WAJIB menggunakan super.key
4. DILARANG menulis business logic di komponen
5. DILARANG melakukan API call di komponen
6. Komponen hanya menerima data via parameter dan callback
7. Semua styling menggunakan AppColors, AppSpacing, AppTextStyles
8. DILARANG menggunakan emoji di komponen

## Dokumentasi per Komponen

Setiap file komponen WAJIB memiliki:

- Comment di atas class menjelaskan tujuan
- Contoh penggunaan di comment
- Dokumentasi setiap parameter

## Daftar Komponen

### PrimaryButton

File: lib/shared/widgets/primary_button.dart

Parameter:

- label (String, required)
- onPressed (VoidCallback?)
- isLoading (bool, default false)
- icon (IconData?)
- fullWidth (bool, default true)

### SecondaryButton

File: lib/shared/widgets/secondary_button.dart

Parameter:

- label (String, required)
- onPressed (VoidCallback?)
- fullWidth (bool, default true)

### CustomAppBar

File: lib/shared/widgets/custom_app_bar.dart

Parameter:

- title (String, required)
- showBackButton (bool, default true)
- actions (List Widget?)
- onBackPressed (VoidCallback?)

### CustomTextField

File: lib/shared/widgets/custom_text_field.dart

Parameter:

- label (String, required)
- hint (String?)
- controller (TextEditingController?)
- keyboardType (TextInputType?)
- obscureText (bool, default false)
- suffixIcon (Widget?)
- prefixIcon (Widget?)
- validator (String? Function(String?)?)
- maxLines (int, default 1)

### EmptyState

File: lib/shared/widgets/empty_state.dart

Parameter:

- title (String, required)
- description (String?)
- icon (IconData, default AppIcons.empty)
- action (Widget?)

### LoadingIndicator

File: lib/shared/widgets/loading_indicator.dart

Parameter:

- size (double, default 24)

### ServiceCard

File: lib/shared/widgets/service_card.dart

Parameter:

- icon (IconData, required)
- title (String, required)
- description (String, required)
- price (String, required)
- onTap (VoidCallback?)

### SectionHeader

File: lib/shared/widgets/section_header.dart

Parameter:

- title (String, required)
- actionLabel (String?)
- onActionTap (VoidCallback?)

### OrderCard

File: lib/shared/widgets/order_card.dart

Parameter:

- icon (IconData, required)
- title (String, required)
- subtitle (String, required)
- status (String, required)
- onTap (VoidCallback?)

### InfoCard

File: lib/shared/widgets/info_card.dart

Parameter:

- title (String, required)
- child (Widget, required)
