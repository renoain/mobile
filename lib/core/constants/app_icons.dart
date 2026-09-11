import 'package:flutter/material.dart';

/// Design tokens icon untuk aplikasi KKOS.
///
/// Sumber icon: Material Icons atau Cupertino Icons.
/// DILARANG menggunakan package icon eksternal.
abstract final class AppIcons {
  // Feature icons
  static const IconData cleaning = Icons.cleaning_services_outlined;
  static const IconData deepCleaning = Icons.auto_awesome_outlined;
  static const IconData organizing = Icons.inventory_2_outlined;
  static const IconData packing = Icons.luggage_outlined;
  static const IconData moving = Icons.local_shipping_outlined;

  // Navigation icons
  static const IconData home = Icons.home_outlined;
  static const IconData orders = Icons.receipt_long_outlined;
  static const IconData profile = Icons.person_outline;

  // Action icons
  static const IconData search = Icons.search;
  static const IconData calendar = Icons.calendar_today_outlined;
  static const IconData location = Icons.location_on_outlined;
  static const IconData chat = Icons.chat_bubble_outline;
  static const IconData call = Icons.phone_outlined;

  // UI icons
  static const IconData back = Icons.arrow_back_ios_new;
  static const IconData close = Icons.close;
  static const IconData chevronRight = Icons.chevron_right;
  static const IconData empty = Icons.inbox_outlined;
  static const IconData visibility = Icons.visibility;
  static const IconData visibilityOff = Icons.visibility_off;
  static const IconData notifications = Icons.notifications_none;
  static const IconData star = Icons.star_rounded;
  static const IconData check = Icons.check_circle_outline;
  static const IconData schedule = Icons.schedule;
  static const IconData bank = Icons.account_balance_outlined;
  static const IconData cash = Icons.payments_outlined;
  static const IconData edit = Icons.edit_outlined;
  static const IconData help = Icons.help_outline;
  static const IconData info = Icons.info_outline;
  static const IconData logout = Icons.logout;
  static const IconData expandDown = Icons.keyboard_arrow_down;
  static const IconData expandUp = Icons.keyboard_arrow_up;

  // Form icons
  static const IconData email = Icons.mail_outline;
  static const IconData lock = Icons.lock_outline;
  static const IconData phone = Icons.phone_outlined;
  static const IconData person = Icons.person_outline;
}
