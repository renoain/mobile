# KKOS Design System

Dokumen ini adalah sumber kebenaran tunggal untuk semua keputusan desain visual di aplikasi KKOS. AI coding assistant WAJIB merujuk ke dokumen ini sebelum membuat atau mengubah UI.

## 1. Prinsip Desain

### 1.1 Clean dan Minimal

Hindari dekorasi yang tidak memiliki fungsi. Setiap elemen visual harus punya alasan keberadaan.

### 1.2 Consistent Spacing

Semua spacing menggunakan kelipatan 4 (8pt grid system).

### 1.3 Clear Hierarchy

Perbedaan visual antar level informasi harus jelas melalui ukuran, weight, dan warna.

### 1.4 Purposeful Color

Warna digunakan untuk komunikasi (status, aksi, feedback), bukan dekorasi.

### 1.5 Flat dengan Border

Gunakan border tipis sebagai pemisah utama. Hindari shadow berlebihan. Elevation maksimal 2.

### 1.6 Gaya Referensi

- Linear (linear.app) - clean, minimal, purposeful
- Notion - flat, border-based, tidak ada shadow
- Stripe Dashboard - tipografi jelas, spacing konsisten
- Vercel Dashboard - monokrom dengan accent color

Yang dihindari:

- Dribbble-style overdesigned
- Glassmorphism berlebihan
- Neumorphism
- Gradient mesh
- 3D illustration yang tidak perlu

## 2. Design Tokens

Semua design token didefinisikan di lib/core/constants/. AI DILARANG menulis nilai hardcoded di widget.

### 2.1 Colors

File: lib/core/constants/app_colors.dart

| Token          | Hex     | Penggunaan                                   |
| -------------- | ------- | -------------------------------------------- |
| primary        | #2563EB | Tombol utama, link, active state, icon aktif |
| primaryDark    | #1D4ED8 | Pressed state tombol primary                 |
| primaryLight   | #DBEAFE | Background icon container, badge             |
| background     | #F8FAFC | Background halaman                           |
| surface        | #FFFFFF | Background card, appbar, bottom nav          |
| surfaceVariant | #F1F5F9 | Background input disabled, chip              |
| textPrimary    | #0F172A | Judul, body utama, label                     |
| textSecondary  | #64748B | Subtitle, deskripsi, caption                 |
| textTertiary   | #94A3B8 | Hint, placeholder, icon non-aktif            |
| textOnPrimary  | #FFFFFF | Text di atas background primary              |
| border         | #E2E8F0 | Border card, input, divider                  |
| divider        | #F1F5F9 | Divider antar list item                      |
| success        | #16A34A | Status sukses, konfirmasi                    |
| warning        | #F59E0B | Status peringatan                            |
| error          | #DC2626 | Status error, validasi gagal                 |
| info           | #0EA5E9 | Informasi netral                             |
| disabled       | #CBD5E1 | Background elemen disabled                   |
| disabledText   | #94A3B8 | Text elemen disabled                         |

Aturan:

- DILARANG menggunakan Colors.blue, Colors.red, atau warna Material default.
- DILARANG membuat gradient kecuali untuk ilustrasi onboarding.
- DILARANG menggunakan opacity di bawah 0.6 untuk text.

### 2.2 Spacing

File: lib/core/constants/app_spacing.dart

| Token | Nilai | Penggunaan                                     |
| ----- | ----- | ---------------------------------------------- |
| xs    | 4     | Jarak antar icon dan text dalam satu baris     |
| sm    | 8     | Jarak antar elemen terkait                     |
| md    | 16    | Padding standar container, jarak antar section |
| lg    | 24    | Padding halaman, jarak antar grup              |
| xl    | 32    | Jarak antar blok besar                         |
| xxl   | 48    | Jarak di empty state, onboarding               |

Aturan:

- Padding halaman default: AppSpacing.md horizontal, AppSpacing.md vertical.
- Jarak antar card dalam list: AppSpacing.sm atau AppSpacing.md.
- Jarak antar section: AppSpacing.lg.

#### Elevation

| Token          | Nilai | Penggunaan                              |
| -------------- | ----- | --------------------------------------- |
| elevationNone  | 0     | Card, appbar default, input             |
| elevationLow   | 1     | Bottom nav, scrolled appbar             |
| elevationMedium| 2     | Elevasi maksimal yang diperbolehkan     |

Aturan:

- DILARANG menggunakan elevation di atas 2.
- Lebih baik pakai border sebagai pemisah daripada shadow.

### 2.3 Border Radius

File: lib/core/constants/app_spacing.dart

| Token      | Nilai | Penggunaan                    |
| ---------- | ----- | ----------------------------- |
| radiusSm   | 6     | Chip, badge, tag              |
| radiusMd   | 10    | Input field, tombol           |
| radiusLg   | 14    | Card, container, bottom sheet |
| radiusFull | 999   | Avatar, pill button           |

Aturan:

- DILARANG menggunakan radius di atas 16 untuk card.
- DILARANG mencampur radius berbeda dalam satu grup elemen.

### 2.4 Typography

File: lib/core/constants/app_text_styles.dart

Font family: Plus Jakarta Sans (via google_fonts package).

| Style         | Size | Weight | Height | Penggunaan                       |
| ------------- | ---- | ------ | ------ | -------------------------------- |
| h1            | 24   | 700    | 1.3    | Judul halaman utama, hero title  |
| h2            | 20   | 600    | 1.3    | Judul section                    |
| h3            | 16   | 600    | 1.4    | Judul card, appbar title         |
| body          | 14   | 400    | 1.5    | Body text, deskripsi             |
| bodySecondary | 14   | 400    | 1.5    | Body text warna secondary        |
| caption       | 12   | 400    | 1.4    | Helper text, timestamp, metadata |
| label         | 13   | 500    | 1.4    | Label input, nama field          |
| button        | 14   | 600    | 1.2    | Text di dalam tombol             |

Aturan:

- DILARANG menggunakan TextStyle() inline di widget. Selalu pakai AppTextStyles.xxx.
- DILARANG mencampur lebih dari 3 ukuran font dalam satu halaman.
- Maksimal 2 weight berbeda per section.

### 2.5 Icon

File: lib/core/constants/app_icons.dart

Sumber icon: Material Icons (Icons.xxx) atau Cupertino Icons.

Aturan:

- DILARANG menggunakan package icon eksternal (Font Awesome, Line Icons, Iconify).
- DILARANG menggunakan gambar PNG atau SVG sebagai icon UI.
- Ukuran icon standar: 16 (sm), 20 (md), 24 (lg), 32 (xl).
- Icon dalam tombol: 20.
- Icon dalam list item: 24.
- Icon di empty state: 64.

Mapping icon per fitur:

| Fitur         | Icon                             |
| ------------- | -------------------------------- |
| Cleaning      | Icons.cleaning_services_outlined |
| Deep Cleaning | Icons.auto_awesome_outlined      |
| Organizing    | Icons.inventory_2_outlined       |
| Packing       | Icons.luggage_outlined           |
| Moving        | Icons.local_shipping_outlined    |
| Home          | Icons.home_outlined              |
| Orders        | Icons.receipt_long_outlined      |
| Profile       | Icons.person_outline             |
| Search        | Icons.search                     |
| Calendar      | Icons.calendar_today_outlined    |
| Location      | Icons.location_on_outlined       |
| Chat          | Icons.chat_bubble_outline        |
| Call          | Icons.phone_outlined             |

## 3. Komponen UI

Semua komponen reusable ada di lib/shared/widgets/. AI WAJIB menggunakan komponen ini dan DILARANG membuat versi duplikat.

Daftar komponen:

- PrimaryButton
- SecondaryButton
- CustomAppBar
- CustomTextField
- EmptyState
- LoadingIndicator
- ServiceCard
- SectionHeader
- OrderCard
- InfoCard

Detail setiap komponen ada di docs/COMPONENT_LIBRARY.md.

## 4. Layout Patterns

### 4.1 Page Layout

Scaffold
AppBar (CustomAppBar) atau SliverAppBar
Body
SafeArea
Padding (horizontal: AppSpacing.md)
ScrollView atau Column

### 4.2 List Item Layout

Padding (AppSpacing.md)
Row
Leading (icon atau avatar, 40-48)
SizedBox (AppSpacing.md)
Expanded
Column
Title (AppTextStyles.h3 atau body)
Subtitle (AppTextStyles.caption)
Trailing (chevron atau action)

### 4.3 Form Layout

Padding (AppSpacing.md)
Column
CustomTextField
SizedBox (AppSpacing.md)
CustomTextField
SizedBox (AppSpacing.lg)
PrimaryButton

### 4.4 Card Layout

Container
Padding (AppSpacing.md)
Column (crossAxisAlignment: start)
Row (header)
SizedBox (AppSpacing.sm)
Body content
SizedBox (AppSpacing.md)
Row (action)

## 5. Anti AI-Slop

Bagian ini berisi panduan spesifik untuk menghindari desain yang terlihat generik, berlebihan, atau "AI-generated".

### 5.1 Gradient Berlebihan

SALAH:
Container(
decoration: BoxDecoration(
gradient: LinearGradient(
colors: [Colors.purple, Colors.pink, Colors.orange],
),
),
)

BENAR:
Container(
decoration: BoxDecoration(
color: AppColors.surface,
border: Border.all(color: AppColors.border),
borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
),
)

### 5.2 Shadow Berlebihan

SALAH:
BoxShadow(
color: Colors.black.withOpacity(0.3),
blurRadius: 30,
spreadRadius: 5,
)

BENAR:
Tidak pakai shadow, gunakan border:
border: Border.all(color: AppColors.border)

### 5.3 Border Radius Berlebihan

SALAH:
BorderRadius.circular(30)

BENAR:
BorderRadius.circular(AppSpacing.radiusLg)

### 5.4 Warna Warni Tanpa Alasan

SALAH:
Setiap card beda warna:
color: index % 2 == 0 ? Colors.blue : Colors.green

BENAR:
Semua card warna sama:
color: AppColors.surface

### 5.5 Font Size Berlebihan

SALAH:
TextStyle(fontSize: 42, fontWeight: FontWeight.w900)

BENAR:
AppTextStyles.h1

### 5.6 Emoji di UI

SALAH:
Text('Selamat datang di KKOS!')

BENAR:
Text('Selamat datang di KKOS')

### 5.7 Icon Terlalu Besar

SALAH:
Icon(Icons.home, size: 80)

BENAR:
Icon(AppIcons.home, size: AppSpacing.iconLg)

### 5.8 Layout Tidak Konsisten

SALAH:

- Halaman 1 padding 20
- Halaman 2 padding 15
- Halaman 3 padding 25

BENAR:

- Semua halaman padding AppSpacing.md

### 5.9 Terlalu Banyak Warna dalam Satu Halaman

SALAH:
Menggunakan 6 warna berbeda dalam satu halaman.

BENAR:
Maksimal 3 warna utama per halaman:

- Primary (untuk aksi)
- Text (untuk konten)
- Background/Surface

### 5.10 Animasi Berlebihan

SALAH:
Setiap widget ada animasi bounce, fade, scale.

BENAR:
Animasi hanya untuk feedback penting:

- Loading state
- Page transition
- Button press

## 6. Checklist Sebelum Commit UI

- Semua warna dari AppColors
- Semua spacing dari AppSpacing (kelipatan 4)
- Semua text style dari AppTextStyles
- Semua icon dari AppIcons atau Material Icons
- Tidak ada emoji
- Pakai komponen reusable dari shared/widgets/
- Border radius maksimal 16
- Tidak ada shadow blurRadius di atas 8
- Maksimal 3 warna per halaman
- Layout konsisten dengan halaman lain
- Tidak ada animasi yang tidak perlu
