# Stitch Design Brief untuk KKOS

Brief ini untuk Google Stitch saat generate desain UI KKOS.
Semua nilai di bawah WAJIB dipakai. Tidak boleh improvisasi.

## Warna

| Penggunaan | Hex |
|------------|-----|
| Primary (tombol, link, active) | #2563EB |
| Primary Dark (pressed) | #1D4ED8 |
| Primary Light (background icon) | #DBEAFE |
| Background halaman | #F8FAFC |
| Surface (card, appbar) | #FFFFFF |
| Border (card, input, divider) | #E2E8F0 |
| Text Primary (judul, body) | #0F172A |
| Text Secondary (subtitle, caption) | #64748B |
| Text Tertiary (hint, placeholder) | #94A3B8 |
| Success | #16A34A |
| Warning | #F59E0B |
| Error | #DC2626 |

Aturan warna:
- Maksimal 3 warna utama per halaman
- Tidak ada gradient kecuali ilustrasi onboarding
- Tidak ada warna di luar tabel di atas

## Typography

Font: Plus Jakarta Sans

| Style | Size | Weight | Penggunaan |
|-------|------|--------|------------|
| H1 | 24 | 700 | Judul halaman utama |
| H2 | 20 | 600 | Judul section |
| H3 | 16 | 600 | Judul card, appbar |
| Body | 14 | 400 | Body text |
| Caption | 12 | 400 | Helper text |
| Label | 13 | 500 | Label input |
| Button | 14 | 600 | Text tombol |

Aturan typography:
- Maksimal 3 ukuran font per halaman
- Maksimal 2 weight berbeda per section

## Spacing

Kelipatan 4 (8pt grid):

| Token | Nilai |
|-------|-------|
| XS | 4 |
| SM | 8 |
| MD | 16 |
| LG | 24 |
| XL | 32 |
| XXL | 48 |

Aturan spacing:
- Padding halaman: 16 (MD)
- Jarak antar section: 24 (LG)
- Jarak antar card: 8-16 (SM-MD)

## Border Radius

| Elemen | Radius |
|--------|--------|
| Chip, badge | 6 |
| Input, tombol | 10 |
| Card, container | 14 |
| Avatar, pill | 999 |

## Gaya Visual

- Flat, tidak ada shadow berlebihan (elevation max 2)
- Border tipis 1px sebagai pemisah utama
- Clean, minimal, mengacu ke Linear, Notion, Stripe Dashboard
- Bukan Dribbble-style overdesigned
- Bukan glassmorphism
- Bukan neumorphism
- Tidak ada gradient mesh

## Icon

Semua icon Material Icons. Contoh:
- Cleaning: cleaning_services
- Packing: luggage
- Moving: local_shipping
- Home: home
- Profile: person
- Search: search
- Calendar: calendar_today
- Location: location_on

## Yang Dilarang di Desain

- Emoji di UI
- Gradient warna-warni
- Shadow blur besar
- Border radius di atas 16 untuk card
- Warna di luar tabel
- Font di luar Plus Jakarta Sans
- Icon di luar Material Icons

## Halaman yang Perlu Didesain

1. Splash
2. Onboarding (3 slide)
3. Login
4. Register
5. Home
6. Service List
7. Service Detail
8. Booking Form
9. Booking Confirm
10. Payment
11. Order List
12. Order Detail
13. Profile
14. Edit Profile
15. Help