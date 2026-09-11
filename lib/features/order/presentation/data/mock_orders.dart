import 'package:flutter/material.dart';

import '../../../../core/constants/app_icons.dart';

/// Status pesanan di KKOS.
enum OrderStatus { active, completed, cancelled }

/// Model pesanan untuk fase UI.
///
/// Data sementara (mock). Saat fase backend, model ini dipindah ke
/// layer domain dan data diambil dari Supabase.
class Order {
  final String id;
  final String title;
  final IconData icon;
  final String schedule;
  final OrderStatus status;
  final String address;
  final String roomSize;
  final int priceValue;
  final String? cleanerName;
  final double? cleanerRating;

  const Order({
    required this.id,
    required this.title,
    required this.icon,
    required this.schedule,
    required this.status,
    required this.address,
    required this.roomSize,
    required this.priceValue,
    this.cleanerName,
    this.cleanerRating,
  });

  int get basePrice => priceValue;

  int get serviceFee => (basePrice * 0.1).round();

  int get total => basePrice + serviceFee;

  String get statusLabel {
    switch (status) {
      case OrderStatus.active:
        return 'Aktif';
      case OrderStatus.completed:
        return 'Selesai';
      case OrderStatus.cancelled:
        return 'Dibatalkan';
    }
  }
}

/// Data mock pesanan KKOS.
abstract final class MockOrders {
  static const List<Order> all = [
    Order(
      id: 'ORD-001',
      title: 'Basic Cleaning Kamar',
      icon: AppIcons.cleaning,
      schedule: 'Senin, 15 Sep 2026, 09:00',
      status: OrderStatus.active,
      address: 'Jl. Kenanga No. 12, Blok C, Cibubur',
      roomSize: 'Kamar sedang (3x3 - 3x4 m)',
      priceValue: 99000,
      cleanerName: 'Andi',
      cleanerRating: 4.9,
    ),
    Order(
      id: 'ORD-002',
      title: 'Packing Pindahan',
      icon: AppIcons.moving,
      schedule: 'Rabu, 17 Sep 2026, 13:00',
      status: OrderStatus.active,
      address: 'Kos Putri Melati, Jl. Mawar No. 5',
      roomSize: 'Kamar besar (3x4 - 4x5 m)',
      priceValue: 249000,
    ),
    Order(
      id: 'ORD-003',
      title: 'Deep Cleaning Kamar',
      icon: AppIcons.deepCleaning,
      schedule: 'Sabtu, 29 Agu 2026, 10:00',
      status: OrderStatus.completed,
      address: 'Jl. Kenanga No. 12, Blok C, Cibubur',
      roomSize: 'Kamar kecil (sampai 3x3 m)',
      priceValue: 199000,
      cleanerName: 'Budi',
      cleanerRating: 4.8,
    ),
    Order(
      id: 'ORD-004',
      title: 'Penataan Lemari',
      icon: AppIcons.organizing,
      schedule: 'Minggu, 16 Agu 2026, 14:00',
      status: OrderStatus.completed,
      address: 'Kos Putri Melati, Jl. Mawar No. 5',
      roomSize: 'Kamar sedang (3x3 - 3x4 m)',
      priceValue: 149000,
      cleanerName: 'Cici',
      cleanerRating: 5.0,
    ),
    Order(
      id: 'ORD-005',
      title: 'Packing Pindahan',
      icon: AppIcons.moving,
      schedule: 'Jumat, 21 Agu 2026, 09:00',
      status: OrderStatus.cancelled,
      address: 'Jl. Kenanga No. 12, Blok C, Cibubur',
      roomSize: 'Kamar besar (3x4 - 4x5 m)',
      priceValue: 249000,
    ),
  ];
}