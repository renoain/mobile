import 'package:flutter/material.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/utils/price_formatter.dart';

/// Kategori layanan di KKOS.
enum ServiceCategory { cleaning, organizing, moving }

/// Model layanan untuk fase UI.
///
/// Data sementara (mock). Saat fase backend, model ini dipindah ke
/// layer domain dan data diambil dari Supabase.
class Service {
  final String id;
  final String name;
  final IconData icon;
  final ServiceCategory category;
  final String description;
  final int priceValue;
  final double rating;
  final int reviewCount;
  final List<String> includes;
  final String duration;

  const Service({
    required this.id,
    required this.name,
    required this.icon,
    required this.category,
    required this.description,
    required this.priceValue,
    required this.rating,
    required this.reviewCount,
    required this.includes,
    required this.duration,
  });

  String get price => PriceFormatter.estimate(priceValue);
}

/// Data mock layanan KKOS.
abstract final class MockServices {
  static const List<Service> all = [
    Service(
      id: 'basic-cleaning',
      name: 'Basic Cleaning',
      icon: AppIcons.cleaning,
      category: ServiceCategory.cleaning,
      description:
          'Pembersihan rutin untuk kamar kos: menyapu, mengepel, membersihkan debu, dan merapikan area utama.',
      priceValue: 99000,
      rating: 4.8,
      reviewCount: 124,
      includes: [
        'Menyapu dan mengepel lantai',
        'Membersihkan debu furnitur',
        'Merapikan tempat tidur',
        'Mengosongkan tempat sampah',
      ],
      duration: '1 - 2 jam',
    ),
    Service(
      id: 'deep-cleaning',
      name: 'Deep Cleaning',
      icon: AppIcons.deepCleaning,
      category: ServiceCategory.cleaning,
      description:
          'Pembersihan menyeluruh termasuk area tersembunyi, dapur, dan kamar mandi dengan detail maksimal.',
      priceValue: 199000,
      rating: 4.9,
      reviewCount: 87,
      includes: [
        'Semua layanan Basic Cleaning',
        'Pembersihan kamar mandi',
        'Pembersihan dapur dan area makan',
        'Menghilangkan noda membandel',
      ],
      duration: '3 - 4 jam',
    ),
    Service(
      id: 'organizing',
      name: 'Penataan Kos',
      icon: AppIcons.organizing,
      category: ServiceCategory.organizing,
      description:
          'Rapikan dan tata ulang barang sesuai kebutuhan agar kamar lebih nyaman dan terorganisir.',
      priceValue: 149000,
      rating: 4.7,
      reviewCount: 56,
      includes: [
        'Penataan lemari dan pakaian',
        'Pengelompokan barang per kategori',
        'Penyusunan meja dan rak',
        'Saran layout kamar',
      ],
      duration: '2 - 3 jam',
    ),
    Service(
      id: 'packing-moving',
      name: 'Packing dan Pindahan',
      icon: AppIcons.moving,
      category: ServiceCategory.moving,
      description:
          'Bantu packing seluruh barang, bongkar di lokasi baru, dan susun kembali dengan rapi.',
      priceValue: 249000,
      rating: 4.8,
      reviewCount: 43,
      includes: [
        'Packing barang dengan aman',
        'Penataan barang di lokasi baru',
        'Koordinasi detail inventaris',
        'Bongkar dan susun ulang',
      ],
      duration: '4 - 6 jam',
    ),
  ];
}