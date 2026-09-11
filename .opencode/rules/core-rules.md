---
name: kkos-core-rules
description: Global rules untuk project KKOS
---

# KKOS Core Rules

## Wajib Dibaca Sebelum Coding

Sebelum membuat atau mengubah kode apapun, baca file berikut di folder docs/:

1. docs/PROJECT_OVERVIEW.md - konteks produk
2. docs/ARCHITECTURE.md - struktur dan arsitektur
3. docs/DESIGN_SYSTEM.md - design token dan anti-AI-slop
4. docs/UI_PAGES.md - spesifikasi halaman
5. docs/COMPONENT_LIBRARY.md - daftar komponen reusable

## Aturan Global

- Stack: Flutter + google_fonts + intl (fase UI)
- Arsitektur: feature-first
- Semua design token dari ---
  name: kkos-core-rules
  description: Global rules untuk project KKOS

---

# KKOS Core Rules

## Wajib Dibaca Sebelum Coding

Sebelum membuat atau mengubah kode apapun, baca file berikut:

1. docs/PROJECT_OVERVIEW.md - konteks produk
2. docs/ARCHITECTURE.md - struktur dan arsitektur
3. docs/DESIGN_SYSTEM.md - design token dan anti-AI-slop
4. docs/UI_PAGES.md - spesifikasi halaman
5. docs/COMPONENT_LIBRARY.md - daftar komponen reusable

## Aturan Operasional

Selain aturan desain dan coding, WAJIB ikuti aturan logging:

- .opencode/rules/logging-rules.md - cara update CHANGELOG.md dan LOGS.md

## Aturan Global

- Stack: Flutter + google_fonts + intl (fase UI)
- Arsitektur: feature-first
- Semua design token dari lib/core/constants/
- Semua komponen reusable dari lib/shared/widgets/
- DILARANG emoji di kode, comment, atau UI
- DILARANG hardcode warna, spacing, atau text style
- DILARANG print(), gunakan debugPrint() jika perlu
- Setiap file Dart WAJIB pakai const constructor jika memungkinkan

## Setelah Setiap Task

1. WAJIB update CHANGELOG.md di root project sesuai format di .opencode/rules/logging-rules.md.
2. WAJIB berikan rekomendasi task selanjutnya berdasarkan:
   - Status progress project saat ini
   - Dependency antar fitur/halaman
   - Prioritas MVP (lihat docs/UI_PAGES.md)
   - Urutan logis build (contoh: Splash -> Onboarding -> Auth -> Home)

## Struktur Folder Wajib

lib/
core/constants/
core/theme/
features/{feature}/presentation/pages/
shared/widgets/

## Bahasa

- Komentar kode: Bahasa Indonesia
- Nama variabel/class: Bahasa Inggris
- String UI: Bahasa Indonesia
- Dokumentasi markdown: Bahasa Indonesia
- Log: Bahasa Indonesialib/core/constants/
- Semua komponen reusable dari lib/shared/widgets/
- DILARANG emoji di kode, comment, atau UI
- DILARANG hardcode warna, spacing, atau text style
- DILARANG print(), gunakan debugPrint() jika perlu
- Setiap file Dart WAJIB pakai const constructor jika memungkinkan

## Struktur Folder Wajib

lib/
core/constants/
core/theme/
features/{feature}/presentation/pages/
shared/widgets/

## Bahasa

- Komentar kode: Bahasa Indonesia
- Nama variabel/class: Bahasa Inggris
- String UI: Bahasa Indonesia
- Dokumentasi markdown: Bahasa Indonesia
