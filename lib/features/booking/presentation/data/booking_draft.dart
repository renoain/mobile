import 'package:flutter/material.dart';

import '../../../service/presentation/data/mock_services.dart';

/// Draft pemesanan yang diisi di BookingFormPage dan dikonfirmasi
/// di BookingConfirmPage.
class BookingDraft {
  final Service service;
  final DateTime date;
  final TimeOfDay time;
  final String address;
  final String? addressNote;
  final String roomSize;
  final String? extraNote;

  const BookingDraft({
    required this.service,
    required this.date,
    required this.time,
    required this.address,
    this.addressNote,
    required this.roomSize,
    this.extraNote,
  });

  int get basePrice => service.priceValue;

  int get serviceFee => (basePrice * 0.1).round();

  int get total => basePrice + serviceFee;
}