---
name: kkos-logging-rules
description: Aturan logging aktivitas untuk project KKOS
---

# Logging Rules

## Tujuan

Setiap kali OpenCode selesai mengerjakan task, WAJIB update file log di root project. Tujuannya agar ada jejak lengkap file apa yang diubah, kapan, dan dengan status verifikasi apa.

## File Log yang Harus Diupdate

Ada dua file log di root project:

1. CHANGELOG.md - ringkasan perubahan, dibaca manusia
2. LOGS.md - detail teknis sesi, untuk debugging

Setiap task selesai WAJIB update minimal CHANGELOG.md. LOGS.md diupdate hanya jika task kompleks atau ada error.

## Aturan CHANGELOG.md

### Format Entri Wajib

### [YYYY-MM-DD] - Nama Task

Status: Selesai / Sedang dikerjakan / Dibatalkan
File yang diubah:

- path/file.dart (dibuat)
- path/file.dart (diedit)
- path/file.dart (dihapus)
  Catatan:
- catatan singkat jika perlu
  Verifikasi:
- flutter analyze: OK / warning / error
- flutter run: OK / crash / belum ditest

### Aturan Penulisan

1. Entri baru ditambahkan di PALING ATAS bagian Riwayat
2. DILARANG menghapus entri lama
3. DILARANG mengedit entri yang sudah selesai
4. Status file: "dibuat", "diedit", atau "dihapus" - pilih salah satu
5. Path file ditulis relatif dari root project
6. Tanggal format YYYY-MM-DD
7. Tidak ada emoji di log

### Kapan Update

- Setiap task selesai
- Setelah flutter analyze dijalankan
- Sebelum lapor ke user

## Aturan LOGS.md

### Format Entri Wajib

### [YYYY-MM-DD HH:MM:SS]

Aktor: OpenCode
Task: deskripsi task
Aksi:

- Baca file: path/file.md
- Buat file: path/file.dart
- Edit file: path/file.dart
- Hapus file: path/file.dart
- Jalankan: flutter analyze
  Hasil:
- Sukses / Gagal / Partial
  Error (jika ada):
- pesan error
  Tindak lanjut:
- langkah berikutnya

### Kapan Update

- Task kompleks (lebih dari 5 file)
- Ada error yang perlu ditrace
- Ada keputusan teknis yang perlu dicatat
- Task gagal atau dibatalkan

Untuk task sederhana, cukup CHANGELOG.md saja.

## Yang Dilarang

1. DILARANG menghapus file CHANGELOG.md atau LOGS.md
2. DILARANG menghapus entri lama di kedua file
3. DILARANG pakai emoji di log
4. DILARANG mengisi log dengan asumsi atau tebakan, isi hanya yang benar-benar dikerjakan
5. DILARANG update log sebelum task benar-benar selesai

## Contoh Entri CHANGELOG yang Benar

### [2026-09-10] - Design Token

Status: Selesai
File yang diubah:

- lib/core/constants/app_colors.dart (dibuat)
- lib/core/constants/app_spacing.dart (dibuat)
- lib/core/constants/app_text_styles.dart (dibuat)
- lib/core/constants/app_icons.dart (dibuat)
  Catatan:
- Semua warna, spacing, typography, icon dari docs/DESIGN_SYSTEM.md
  Verifikasi:
- flutter analyze: OK

## Contoh Entri CHANGELOG yang Salah

### hari ini

udah bikin app_colors.dart sama app_spacing.dart

Kenapa salah:

- Tanggal tidak format YYYY-MM-DD
- Status tidak ada
- File list tidak ada
- Verifikasi tidak ada
- Bahasa informal

## Checklist Sebelum Update Log

- Format sesuai template
- Tanggal benar
- Path file benar
- Status file benar (dibuat/diedit/dihapus)
- Hasil flutter analyze dicatat
- Entri baru di paling atas
- Tidak ada emoji
