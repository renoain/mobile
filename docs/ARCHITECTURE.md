# KKOS Architecture

Dokumen ini menjelaskan arsitektur aplikasi KKOS agar AI coding assistant memahami struktur dan alur kode.

## Stack Teknologi

Fase UI (sekarang):

- Framework: Flutter
- Font: google_fonts (Plus Jakarta Sans)
- Format: intl

Fase berikutnya:

- State Management: Riverpod
- Navigation: go_router
- Backend: Supabase
- HTTP Client: Dio

## Layer Architecture

Presentation - Domain - Data - External (Supabase)

Aturan dependency:

- Presentation boleh import Domain
- Domain TIDAK boleh import Presentation atau Data
- Data implement interface dari Domain
- External hanya diakses via Data layer

Untuk fase UI, cukup folder presentation dulu. Folder data dan domain ditambahkan saat masuk fase backend.

## Struktur Folder

lib/
main.dart
app.dart
core/
constants/
theme/
utils/
errors/
features/
auth/
presentation/
pages/
widgets/
onboarding/
splash/
home/
service/
booking/
payment/
order/
profile/
shared/
widgets/
extensions/

## Feature-First Architecture

Setiap fitur punya folder sendiri di lib/features/. Untuk fase UI, cukup folder presentation dulu.

Contoh untuk fitur auth:

- lib/features/auth/presentation/pages/login_page.dart
- lib/features/auth/presentation/pages/register_page.dart
- lib/features/auth/presentation/widgets/login_form.dart

## Routing

Rencana route (belum diimplementasikan, akan pakai go_router di fase berikutnya):

- / - Splash
- /onboarding - Onboarding
- /login - Login
- /register - Register
- /home - Home
- /services - Service List
- /services/:id - Service Detail
- /booking/:serviceId - Booking Form
- /booking/confirm - Booking Confirmation
- /payment/:orderId - Payment
- /orders - Order List
- /orders/:id - Order Detail
- /profile - Profile
- /profile/edit - Edit Profile
- /help - Help

## Naming Convention

- File: snake_case.dart
- Class: PascalCase
- Variable/Function: camelCase
- Constant: camelCase (bukan SCREAMING_CASE)
- Private: prefix \_

## Import Order

1. Dart core (dart:async)
2. Flutter (package:flutter/material.dart)
3. Third-party (package:google_fonts/...)
4. Local (relative path)

## Error Handling

Untuk fase UI, error handling minimal. Nanti saat backend, gunakan sealed class Result.

## Yang Dilarang

- print() - pakai debugPrint() jika perlu
- setState untuk state global
- Business logic di widget
- Direct HTTP call di widget
- Hardcode string - pakai konstanta
- Hardcode warna, spacing, text style
