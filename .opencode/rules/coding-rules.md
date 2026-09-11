---
name: kkos-coding-rules
description: Konvensi kode Dart/Flutter untuk KKOS
---

# Coding Rules

## Naming Convention

- File: snake_case.dart
- Class: PascalCase
- Variable/Function: camelCase
- Constant: camelCase (bukan SCREAMING_CASE)
- Private: prefix \_

## Struktur File Dart

1. Imports (dart, flutter, packages, local)
2. Class declaration
3. Constructor (const jika memungkinkan)
4. Fields
5. Lifecycle methods
6. Build method
7. Private methods

## Import Order

1. Dart core (dart:async)
2. Flutter (package:flutter/material.dart)
3. Third-party (package:google_fonts/...)
4. Local (relative path)

## Konvensi Widget

- Semua page extends StatelessWidget (untuk fase UI)
- Semua komponen reusable extends StatelessWidget
- WAJIB pakai const constructor
- WAJIB pakai super.key
- DILARANG business logic di widget
- DILARANG setState untuk state global

## Yang Dilarang

- print() - pakai debugPrint() jika perlu
- Hardcode string UI - pakai konstanta
- Hardcode warna, spacing, text style
- Emoji di kode atau comment
- Duplikasi komponen
- Nested widget terlalu dalam (maksimal 5 level)

## Format Kode

- Indentasi: 2 spasi
- Trailing comma: WAJIB di setiap argumen terakhir
- Line length: maksimal 80 karakter
- Setiap file diakhiri newline

## Komentar

- Komentar seperlunya, jelaskan "kenapa" bukan "apa"
- Bahasa Indonesia
- DILARANG komentar bercanda atau tidak profesional
