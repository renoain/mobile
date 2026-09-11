# KKOS UI Pages Specification

Dokumen ini mendefinisikan setiap halaman yang akan dibuat. AI WAJIB mengikuti spesifikasi ini saat membuat halaman baru.

## Konvensi Penamaan

- File page: snake_case_page.dart di lib/features/{feature}/presentation/pages/
- Class page: PascalCasePage
- Setiap page extends StatelessWidget atau ConsumerWidget (jika pakai Riverpod)
- Setiap page WAJIB punya const constructor

## Daftar Halaman MVP

### 1. SplashPage

Path: lib/features/splash/presentation/pages/splash_page.dart
Route: /

Komponen:

- Logo KKOS di tengah
- Loading indicator di bawah logo

Layout:

- Background: AppColors.background
- Logo: ukuran 120x120
- Jarak logo ke loading: AppSpacing.xl

### 2. OnboardingPage

Path: lib/features/onboarding/presentation/pages/onboarding_page.dart
Route: /onboarding

Komponen:

- PageView dengan 3 slide
- Setiap slide: ilustrasi, judul, deskripsi
- Indicator dots di bawah
- Tombol Lanjut atau Mulai

Layout:

- Padding: AppSpacing.lg
- Ilustrasi: tinggi 240
- Judul: AppTextStyles.h1
- Deskripsi: AppTextStyles.bodySecondary

### 3. LoginPage

Path: lib/features/auth/presentation/pages/login_page.dart
Route: /login

Komponen:

- Judul "Masuk ke Akun"
- Subtitle "Silakan masuk untuk melanjutkan"
- CustomTextField email
- CustomTextField password dengan suffix visibility toggle
- PrimaryButton "Masuk"
- Text button "Lupa password"
- Divider "atau"
- OutlinedButton "Masuk dengan Google"
- Row "Belum punya akun? Daftar"

Layout:

- Padding horizontal: AppSpacing.lg
- Jarak antar field: AppSpacing.md
- Jarak field ke button: AppSpacing.lg

### 4. RegisterPage

Path: lib/features/auth/presentation/pages/register_page.dart
Route: /register

Komponen:

- Judul "Buat Akun Baru"
- CustomTextField nama lengkap
- CustomTextField email
- CustomTextField nomor HP
- CustomTextField password dengan suffix visibility toggle
- CustomTextField konfirmasi password
- Checkbox setuju syarat dan ketentuan
- PrimaryButton "Daftar"
- Row "Sudah punya akun? Masuk"

### 5. HomePage

Path: lib/features/home/presentation/pages/home_page.dart
Route: /home

Komponen:

- CustomAppBar dengan title "KKOS" dan action notification
- Greeting section: "Halo, {nama}" dan subtitle
- Search bar (read-only, tap untuk ke search page)
- Section "Layanan Kami" dengan grid 2 kolom ServiceCard
- Section "Pesanan Aktif" dengan list order card
- Bottom navigation bar

Layanan:

- Basic Cleaning
- Deep Cleaning
- Penataan Kos
- Packing dan Pindahan

### 6. ServiceListPage

Path: lib/features/service/presentation/pages/service_list_page.dart
Route: /services

Komponen:

- CustomAppBar "Semua Layanan"
- Filter chip: Semua, Cleaning, Penataan, Pindahan
- List ServiceCard vertikal

### 7. ServiceDetailPage

Path: lib/features/service/presentation/pages/service_detail_page.dart
Route: /services/:id

Komponen:

- CustomAppBar dengan title nama layanan
- Hero image atau icon besar
- Nama layanan: AppTextStyles.h1
- Rating dan jumlah review
- Harga mulai: AppTextStyles.h2 dengan warna primary
- Section "Deskripsi"
- Section "Yang Termasuk" dengan checklist
- Section "Durasi"
- Bottom bar: PrimaryButton "Pesan Sekarang"

### 8. BookingFormPage

Path: lib/features/booking/presentation/pages/booking_form_page.dart
Route: /booking/:serviceId

Komponen:

- CustomAppBar "Pesan Layanan"
- Step indicator (1/2 atau 2/2)
- Section "Jadwal"
  - Date picker
  - Time picker
- Section "Alamat"
  - CustomTextField alamat lengkap
  - CustomTextField catatan alamat
- Section "Detail Kamar"
  - Dropdown ukuran kamar
  - CustomTextField catatan tambahan
- Bottom bar: PrimaryButton "Lanjut"

### 9. BookingConfirmPage

Path: lib/features/booking/presentation/pages/booking_confirm_page.dart
Route: /booking/confirm

Komponen:

- CustomAppBar "Konfirmasi Pesanan"
- Card ringkasan layanan
- Card detail jadwal
- Card detail alamat
- Card rincian harga
- Bottom bar: PrimaryButton "Konfirmasi Pesanan"

### 10. PaymentPage

Path: lib/features/payment/presentation/pages/payment_page.dart
Route: /payment/:orderId

Komponen:

- CustomAppBar "Pembayaran"
- Card total pembayaran
- Section metode pembayaran (radio button)
  - Transfer Bank
  - COD
- Info rekening tujuan
- PrimaryButton "Upload Bukti Bayar"

### 11. OrderListPage

Path: lib/features/order/presentation/pages/order_list_page.dart
Route: /orders

Komponen:

- CustomAppBar "Pesanan Saya"
- TabBar: Aktif, Selesai, Dibatalkan
- List order card dengan status badge

### 12. OrderDetailPage

Path: lib/features/order/presentation/pages/order_detail_page.dart
Route: /orders/:id

Komponen:

- CustomAppBar "Detail Pesanan"
- Status tracker (timeline)
- Card info layanan
- Card info cleaner (jika sudah ada)
- Card detail jadwal dan alamat
- Card rincian harga
- Action buttons: Chat, Call
- PrimaryButton "Batalkan Pesanan" (jika masih bisa)

### 13. ProfilePage

Path: lib/features/profile/presentation/pages/profile_page.dart
Route: /profile

Komponen:

- CustomAppBar "Profil"
- Avatar dan nama user
- Menu list:
  - Edit Profil
  - Alamat Tersimpan
  - Metode Pembayaran
  - Notifikasi
  - Bantuan
  - Tentang Aplikasi
  - Keluar

### 14. EditProfilePage

Path: lib/features/profile/presentation/pages/edit_profile_page.dart
Route: /profile/edit

Komponen:

- CustomAppBar "Edit Profil"
- Avatar dengan tombol edit
- CustomTextField nama
- CustomTextField email (disabled)
- CustomTextField nomor HP
- PrimaryButton "Simpan"

### 15. HelpPage

Path: lib/features/profile/presentation/pages/help_page.dart
Route: /help

Komponen:

- CustomAppBar "Bantuan"
- Search bar
- List FAQ dengan expandable tile
- Section "Hubungi Kami" dengan tombol WhatsApp dan Email

## Checklist Setiap Halaman Baru

- File di path yang benar
- Class extends StatelessWidget atau ConsumerWidget
- Constructor const
- Menggunakan CustomAppBar (jika perlu appbar)
- Semua spacing dari AppSpacing
- Semua warna dari AppColors
- Semua text style dari AppTextStyles
- Menggunakan widget reusable dari shared/widgets
- Tidak ada emoji
- Tidak ada hardcoded value
- Sudah responsive (test di layar kecil dan besar)
