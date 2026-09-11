---
name: kkos-design-rules
description: Aturan desain wajib untuk KKOS
---

# Design Rules - KKOS

## Prinsip Utama

1. Clean dan Minimal
2. Consistent Spacing (kelipatan 4)
3. Clear Hierarchy
4. Purposeful Color
5. Flat dengan Border

Gaya referensi: Linear, Notion, Stripe Dashboard, Vercel Dashboard.

## Detail Lengkap

Detail design token, komponen, layout pattern, dan panduan anti-AI-slop ada di:
docs/DESIGN_SYSTEM.md

WAJIB baca file tersebut sebelum coding UI.

## Larangan Singkat

- DILARANG emoji di kode, comment, atau UI
- DILARANG hardcode warna, spacing, text style
- DILARANG gradient kecuali ilustrasi onboarding
- DILARANG shadow blurRadius di atas 8
- DILARANG border radius di atas 16 untuk card
- DILARANG icon dari package eksternal
- DILARANG buat komponen duplikat
- DILARANG pakai lebih dari 3 warna per halaman

## Checklist Cepat Sebelum Commit UI

- Warna dari AppColors
- Spacing dari AppSpacing
- Text style dari AppTextStyles
- Icon dari AppIcons atau Material Icons
- Pakai komponen dari shared/widgets/
- Tidak ada emoji
- Layout konsisten dengan halaman lain
