# CHANGELOG

Riwayat perubahan project KKOS.

---

### [2026-09-11] - Mode Guest dan Gate Login untuk Booking

Status: Selesai

File yang dibuat:

- lib/features/auth/data/auth_state.dart (dibuat) - singleton status autentikasi (guest / logged-in)

File yang diubah:

- lib/features/onboarding/presentation/pages/onboarding_page.dart (diedit) - tambah tombol "Lewati, Masuk sebagai Tamu" di slide terakhir yang pushReplacement ke HomePage
- lib/features/home/presentation/pages/home_page.dart (diedit) - banner guest di atas halaman, greeting "Halo, Tamu", section Pesanan Aktif hanya untuk logged-in, tombol Masuk di banner
- lib/features/service/presentation/pages/service_detail_page.dart (diedit) - tombol "Pesan Sekarang" cek AuthState; tamu melihat dialog "Login Diperlukan" dengan aksi Nanti Saja / Masuk
- lib/features/auth/presentation/pages/login_page.dart (diedit) - set AuthState.setLoggedIn() lalu pushAndRemoveUntil ke HomePage
- lib/features/auth/presentation/pages/register_page.dart (diedit) - set AuthState.setLoggedIn() lalu pushAndRemoveUntil ke HomePage
- lib/features/profile/presentation/pages/profile_page.dart (diedit) - header tampil "Tamu" + tombol Masuk saat guest; menu khusus guest (Metode Pembayaran, Bantuan, Tentang Aplikasi); "Keluar" setLoggedOut lalu kembali ke HomePage sebagai guest; menu login pindah ke dalam profil
- lib/features/order/presentation/pages/order_list_page.dart (diedit) - tamu melihat EmptyState "Login untuk melihat pesanan" dengan tombol Masuk

Catatan:

- AuthState masih singleton sederhana tanpa ChangeNotifier; HomePage/ProfilePage membaca status saat build
- Navigasi login/register/logout pakai pushAndRemoveUntil agar stack bersih dan tidak ada HomePage ganda
- Banner guest hanya tampil di tab Beranda; tab Pesanan dan Profil punya prompt login masing-masing
- Alur baru: Splash -> Onboarding -> (Mulai -> Login) atau (Lewati sebagai Tamu -> Home); booking tetap butuh login

Verifikasi:

- flutter analyze: OK (no issues found)
- flutter test: OK (1 test passed)

---

### [2026-09-10] - ProfilePage, EditProfilePage, dan HelpPage

Status: Selesai

File yang dibuat:

- lib/features/profile/presentation/data/mock_user.dart (dibuat) - MockUser (nama, email, nomor HP)
- lib/features/profile/presentation/pages/profile_page.dart (dibuat) - avatar, nama, dan menu list (Edit Profil, Alamat Tersimpan, Metode Pembayaran, Notifikasi, Bantuan, Tentang Aplikasi, Keluar)
- lib/features/profile/presentation/pages/edit_profile_page.dart (dibuat) - avatar dengan tombol edit, form nama (validasi), email (disabled), nomor HP, tombol Simpan
- lib/features/profile/presentation/pages/help_page.dart (dibuat) - search bar fungsional, FAQ expandable, section Hubungi Kami (WhatsApp/Email)

File yang diubah:

- lib/core/constants/app_icons.dart (diedit) - tambah AppIcons.edit, help, info, logout, expandDown, expandUp
- lib/features/home/presentation/pages/home_page.dart (diedit) - tab Profil sekarang ProfilePage (placeholder dan import EmptyState dihapus)

Catatan:

- Menu Alamat Tersimpan, Metode Pembayaran, Notifikasi, Tentang Aplikasi masih no-op
- "Keluar" di profil pushReplacement ke LoginPage (mock)
- Edit Profil menyimpan secara lokal (snackbar) lalu pop; data tidak disinkronkan ke state global (belum ada state management)
- FAQ pakai set index buatan sendiri (bukan ExpansionTile) agar styling konsisten dengan design system
- WhatsApp/Email masih snackbar placeholder

Verifikasi:

- flutter analyze: OK (no issues found)
- flutter test: OK (1 test passed)

---

### [2026-09-10] - OrderListPage dan OrderDetailPage

Status: Selesai

File yang dibuat:

- lib/shared/widgets/info_card.dart (dibuat) - card ringkasan dengan judul dan konten (dipakai BookingConfirm + OrderDetail)
- lib/shared/widgets/order_card.dart (dibuat) - card pesanan untuk list (icon, title, subtitle, status badge)
- lib/features/order/presentation/data/mock_orders.dart (dibuat) - model Order, enum OrderStatus, MockOrders.all (5 pesanan: aktif/selesai/dibatalkan)
- lib/features/order/presentation/pages/order_list_page.dart (dibuat) - TabBar (Aktif/Selesai/Dibatalkan) + list OrderCard
- lib/features/order/presentation/pages/order_detail_page.dart (dibuat) - timeline status 4 langkah, info layanan, petugas, jadwal+alamat, rincian harga, aksi Chat/Telepon, tombol Batalkan (aktif)

File yang diubah:

- lib/features/home/presentation/pages/home_page.dart (diedit) - tab Pesanan sekarang OrderListPage (placeholder dihapus); pesanan aktif pakai MockOrders + OrderCard; _OrderItem/_OrderCard dihapus
- lib/features/booking/presentation/pages/booking_confirm_page.dart (diedit) - pakai shared InfoCard, _SummaryCard dihapus

Catatan:

- Timeline: 4 node dengan garis penghubung; node aktif saat pesanan sedang dikerjakan, selesai = semua check
- MockOrders bersumber dari satu tempat (tiga status), dipakai HomePage aktif + OrderListPage
- Chat/Telepon masih SnackBar placeholder; tombol Batalkan untuk status aktif saja
- InfoCard dipromosikan dari _SummaryCard BookingConfirm → komponen shared

Verifikasi:

- flutter analyze: OK (no issues found)
- flutter test: OK (1 test passed)

---

### [2026-09-10] - PaymentPage

Status: Selesai

File yang dibuat:

- lib/features/payment/presentation/pages/payment_page.dart (dibuat) - card total pembayaran, radio metode (Transfer Bank / COD), info rekening tujuan, bottom bar tombol upload bukti

File yang diubah:

- lib/core/constants/app_icons.dart (diedit) - tambah AppIcons.bank dan AppIcons.cash
- lib/features/booking/presentation/data/booking_draft.dart (diedit) - tambah getter basePrice, serviceFee, total (fee 10%), satu sumber perhitungan
- lib/features/booking/presentation/pages/booking_confirm_page.dart (diedit) - pakai getter draft; "Konfirmasi Pesanan" push ke PaymentPage

Catatan:

- Radio memakai RadioGroup (groupValue/onChanged di RadioListTile deprecated di Flutter >= 3.32)
- Info rekening mock (Bank BCA), hanya tampil saat metode Transfer terpilih
- "Upload Bukti Bayar" masih SnackBar placeholder (belum ada file picker/upload)
- Perhitungan harga dipindah ke BookingDraft agar satu sumber (confirm + payment)

Verifikasi:

- flutter analyze: OK (no issues found)
- flutter test: OK (1 test passed)

---

### [2026-09-10] - BookingFormPage dan BookingConfirmPage

Status: Selesai

File yang dibuat:

- lib/core/utils/date_formatter.dart (dibuat) - format tanggal dan jam Bahasa Indonesia
- lib/core/utils/price_formatter.dart (dibuat) - format rupiah (NumberFormat pattern #.###)
- lib/features/booking/presentation/data/booking_draft.dart (dibuat) - model draft pemesanan antar halaman
- lib/features/booking/presentation/pages/booking_form_page.dart (dibuat) - 2 step: jadwal (date/time picker) dan alamat, lalu detail kamar (dropdown ukuran + catatan)
- lib/features/booking/presentation/pages/booking_confirm_page.dart (dibuat) - ringkasan layanan, jadwal, alamat, detail kamar, rincian harga (layanan + fee 10% + total)

File yang diubah:

- lib/core/constants/app_icons.dart (diedit) - tambah AppIcons.schedule
- lib/features/service/presentation/data/mock_services.dart (diedit) - tambah priceValue (int), String price jadi getter dari PriceFormatter.estimate
- lib/features/service/presentation/pages/service_detail_page.dart (diedit) - tombol "Pesan Sekarang" push ke BookingFormPage

Catatan:

- _PickerField (tanggal/jam) masih local widget di booking_form_page, kandidat komponen shared (readonly tappable field)
- DropdownButtonFormField memakai initialValue (value deprecated di Flutter >= 3.33)
- "Konfirmasi Pesanan" masih SnackBar placeholder (PaymentPage belum dibuat)
- Rincian harga mock: fee 10% dibulatkan, total = layanan + fee

Verifikasi:

- flutter analyze: OK (no issues found)
- flutter test: OK (1 test passed)

---

### [2026-09-10] - ServiceListPage dan ServiceDetailPage

Status: Selesai

File yang dibuat:

- lib/features/service/presentation/data/mock_services.dart (dibuat) - model Service, enum ServiceCategory, dan MockServices.all (4 layanan)
- lib/features/service/presentation/pages/service_list_page.dart (dibuat) - daftar layanan dengan filter chip kategori, list ServiceCard vertikal
- lib/features/service/presentation/pages/service_detail_page.dart (dibuat) - icon hero, nama, rating, harga, deskripsi, yang termasuk, durasi, bottom bar Pesan Sekarang

File yang diubah:

- lib/core/constants/app_icons.dart (diedit) - tambah AppIcons.star dan AppIcons.check
- lib/features/home/presentation/pages/home_page.dart (diedit) - pakai MockServices, "Lihat Semua" ke ServiceListPage, card layanan ke ServiceDetailPage, _ServiceItem dihapus

Catatan:

- Data layanan dipindah dari hardcode HomePage ke satu sumber (MockServices)
- ServiceDetailPage menerima objek Service langsung (belum ada go_router, route /services/:id belum berbasis path)
- Tombol "Pesan Sekarang" masih SnackBar placeholder (BookingForm belum dibuat)
- ServiceDetailPage stateless karena tidak ada state

Verifikasi:

- flutter analyze: OK (no issues found)

---

### [2026-09-10] - HomePage dan Fix Alur Navigasi

Status: Selesai

File yang dibuat:

- lib/features/home/presentation/pages/home_page.dart (dibuat) - greeting, search bar, grid layanan 2 kolom, daftar pesanan aktif, bottom nav 3 tab (Beranda/Pesanan/Profil)

File yang diubah:

- lib/features/splash/presentation/pages/splash_page.dart (diedit) - sekarang StatefulWidget dengan Timer 2 detik lalu pushReplacement ke OnboardingPage (sebelumnya stuck di logo)
- lib/core/constants/app_icons.dart (diedit) - tambah token AppIcons.notifications
- lib/features/auth/presentation/pages/login_page.dart (diedit) - submit login pushReplacement ke HomePage
- lib/features/auth/presentation/pages/register_page.dart (diedit) - submit register pushReplacement ke HomePage

Catatan:

- Alur sekarang: Splash -> Onboarding -> Login/Register -> Home
- Data layanan dan pesanan masih mock (hardcode di page, belum ada data layer)
- Tab Pesanan dan Profil masih placeholder EmptyState (halaman belum dibuat)
- Grid pakai GridView shrinkWrap + NeverScrollableScrollPhysics di dalam SingleChildScrollView
- Tombol Lihat Semua, search, dan card layanan belum punya target navigasi (ServiceList/Detail belum ada)

Verifikasi:

- flutter analyze: OK (no issues found)

---

### [2026-09-10] - LoginPage dan RegisterPage

Status: Selesai

File yang dibuat:

- lib/features/auth/presentation/pages/login_page.dart (dibuat) - form email + password dengan toggle visibility, lupa password, divider, login Google, link ke register
- lib/features/auth/presentation/pages/register_page.dart (dibuat) - form nama, email, nomor HP, password, konfirmasi password, checkbox syarat dan ketentuan

File yang diubah:

- lib/core/constants/app_icons.dart (diedit) - tambah token AppIcons.visibility dan AppIcons.visibilityOff
- lib/features/onboarding/presentation/pages/onboarding_page.dart (diedit) - tombol "Mulai" sekarang pushReplacement ke LoginPage (sebelumnya pop placeholder)

Catatan:

- Validasi hanya dasar (required, format email, min 6, password sama)
- Submit masih mock (SnackBar) karena backend belum ada
- Tombol "Masuk dengan Google" disabled sementara
- String validasi inline belum dipindah ke konstanta (belum ada file strings)

Verifikasi:

- flutter analyze: OK (no issues found)

---

### [2026-09-10] - OnboardingPage

Status: Selesai

File yang dibuat:

- lib/features/onboarding/presentation/pages/onboarding_page.dart (dibuat) - 3 slide PageView (cleaning, penataan, pindahan) dengan dots indicator dan tombol Lanjut/Mulai

Catatan:

- Ilustrasi berupa container surface ber-border dengan box icon primaryLight (tidak ada asset ilustrasi)
- Tombol "Mulai" sementara pop ke halaman sebelumnya; belum ada router dan LoginPage
- Durasi animasi page transition hardcoded 300ms (belum ada motion token)
- Mengikuti docs/UI_PAGES.md dan docs/DESIGN_SYSTEM.md

Verifikasi:

- flutter analyze: OK (no issues found)

---

### [2026-09-10] - SplashPage

Status: Selesai

File yang dibuat:

- lib/features/splash/presentation/pages/splash_page.dart (dibuat) - halaman splash dengan logo KKOS 120x120 dan LoadingIndicator

File yang diubah:

- lib/app.dart (diedit) - home sekarang SplashPage, placeholder Scaffold dihapus

Catatan:

- Logo KKOS sementara berupa container primary rounded dengan text "KKOS" (belum ada asset logo)
- Ikuti spesifikasi docs/UI_PAGES.md (background, ukuran logo, jarak logo ke loading)
- Loading indicator pakai LoadingIndicator dari shared/widgets

Verifikasi:

- flutter analyze: OK (no issues found)

---

### [2026-09-10] - Shared Components (Reusable Widgets)

Status: Selesai

File yang dibuat:

- lib/shared/widgets/primary_button.dart (dibuat) - tombol utama dengan loading state
- lib/shared/widgets/secondary_button.dart (dibuat) - tombol sekunder dengan border
- lib/shared/widgets/custom_app_bar.dart (dibuat) - AppBar kustom dengan back button
- lib/shared/widgets/custom_text_field.dart (dibuat) - input field dengan label
- lib/shared/widgets/empty_state.dart (dibuat) - widget state kosong
- lib/shared/widgets/loading_indicator.dart (dibuat) - indicator loading
- lib/shared/widgets/service_card.dart (dibuat) - card info layanan
- lib/shared/widgets/section_header.dart (dibuat) - header section dengan action

Catatan:

- Semua komponen menggunakan design token dari lib/core/constants/
- Menggunakan const constructor dan super.key
- Import order sesuai coding rules
- Dari docs/COMPONENT_LIBRARY.md

Verifikasi:

- flutter analyze: OK (no issues found)

---

### [2026-09-10] - Tambah Elevation Tokens dan Docs Update

Status: Selesai

File yang diubah:

- docs/DESIGN_SYSTEM.md (diedit) - tambah sub-section Elevation di 2.2 Spacing

Catatan:

- CardTheme -> CardThemeData sudah diperbaiki di sesi sebelumnya
- Elevation tokens (elevationNone, elevationLow, elevationMedium) sudah ada di app_spacing.dart
- Dokumentasi DESIGN_SYSTEM.md belum punya section elevation, sekarang sudah lengkap

Verifikasi:

- flutter analyze: OK (no issues found)

---

### [2026-09-10] - Design Tokens dan Theme

Status: Selesai

File yang dibuat:

- lib/core/constants/app_colors.dart (dibuat) - 18 color tokens
- lib/core/constants/app_spacing.dart (dibuat) - spacing, border radius, icon size, elevation tokens
- lib/core/constants/app_text_styles.dart (dibuat) - 8 typography styles (Plus Jakarta Sans)
- lib/core/constants/app_icons.dart (dibuat) - icon constants per fitur
- lib/core/theme/app_theme.dart (dibuat) - ThemeData light config (Material 3)
- lib/app.dart (dibuat) - widget root aplikasi dengan placeholder
- lib/core/utils/ (dibuat) - direktori placeholder
- lib/core/errors/ (dibuat) - direktori placeholder
- lib/shared/widgets/ (dibuat) - direktori placeholder
- lib/shared/extensions/ (dibuat) - direktori placeholder

File yang diubah:

- lib/main.dart (diedit) - gunakan App widget dari app.dart
- pubspec.yaml (diedit) - tambah google_fonts, intl; register assets

Catatan:

- Semua design token mengikuti DESIGN_SYSTEM.md
- Theme menggunakan Material 3 dengan color scheme kustom
- Placeholder sementara di app.dart akan diganti saat buat Splash/Onboarding
- Baris komentar di pubspec.yaml dihapus untuk kebersihan

Verifikasi:

- flutter analyze: OK (no issues found)
- flutter test: OK (1 test passed)

---

### [2026-09-10] - Setup File Wajib Project

Status: Selesai

File yang diubah:

- analysis_options.yaml (diedit)
- .gitignore (diedit)
- README.md (diedit)
- assets/images/.gitkeep (dibuat)
- assets/icons/.gitkeep (dibuat)
- docs/GLOSSARY.md (dibuat)
- CHANGELOG.md (dibuat)

Catatan:

- Setup file wajib sebelum masuk coding Dart
- analysis_options.yaml: tambah linter rules ketat (prefer_const_constructors, avoid_print, dll) dan exclude pattern untuk .g.dart/.freezed.dart
- .gitignore: tambah .env, opencode-log, .vscode/, Thumbs.db
- README.md: rewrite dengan struktur folder, link dokumentasi, dan setup instructions
- CHANGELOG.md: dibuat dengan format standar

Verifikasi:

- flutter analyze: OK (no issues found)
