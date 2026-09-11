# KKOS

Aplikasi mobile marketplace jasa kebersihan, penataan, dan pindahan khusus untuk anak kos.

## Status

Fase UI Development. Backend belum diintegrasikan. Semua data masih mock data.

## Tech Stack

- Flutter
- google_fonts (Plus Jakarta Sans)
- intl

Fase berikutnya:

- Riverpod (state management)
- go_router (navigation)
- Supabase (backend)
- Dio (HTTP client)

## Struktur Project

```
lib/
  main.dart
  app.dart
  core/
    constants/     -- Design token (warna, spacing, typography, icon)
    theme/         -- Konfigurasi tema
    utils/         -- Utilitas umum
    errors/        -- Penanganan error
  features/
    auth/          -- Autentikasi (login, register)
    onboarding/    -- Onboarding
    splash/        -- Splash screen
    home/          -- Halaman utama
    service/       -- Katalog layanan
    booking/       -- Form pemesanan
    payment/       -- Pembayaran
    order/         -- Riwayat pesanan
    profile/       -- Profil user
  shared/
    widgets/       -- Komponen reusable
    extensions/    -- Extension Dart
```

## Dokumentasi

- [Project Overview](docs/PROJECT_OVERVIEW.md) -- Konteks produk dan target user
- [Architecture](docs/ARCHITECTURE.md) -- Arsitektur dan struktur folder
- [Design System](docs/DESIGN_SYSTEM.md) -- Design token dan panduan anti-AI-slop
- [UI Pages](docs/UI_PAGES.md) -- Spesifikasi setiap halaman
- [Component Library](docs/COMPONENT_LIBRARY.md) -- Daftar komponen reusable
- [Glossary](docs/GLOSSARY.md) -- Kamus istilah project

## Setup

```bash
flutter pub get
flutter run
```

## Riwayat Perubahan

Lihat [CHANGELOG.md](CHANGELOG.md) untuk detail perubahan.

## Lisensi

Private.
