import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import 'mock_orders.dart';

/// Pemetaan warna status pesanan ke token palette.
///
/// Background memakai warna status dengan alpha rendah agar tetap
/// dalam palette dan tidak menambah warna baru.
extension OrderStatusStyle on OrderStatus {
  Color get color {
    switch (this) {
      case OrderStatus.active:
        return AppColors.primary;
      case OrderStatus.completed:
        return AppColors.success;
      case OrderStatus.cancelled:
        return AppColors.error;
    }
  }

  Color get background {
    switch (this) {
      case OrderStatus.active:
        return AppColors.primaryLight;
      case OrderStatus.completed:
        return AppColors.success.withValues(alpha: 0.12);
      case OrderStatus.cancelled:
        return AppColors.error.withValues(alpha: 0.1);
    }
  }
}