import 'package:intl/intl.dart';

/// Formatter harga rupiah untuk aplikasi KKOS.
abstract final class PriceFormatter {
  static final NumberFormat _format = NumberFormat('#.###');

  static String rupiah(int value) => 'Rp ${_format.format(value)}';

  static String estimate(int base) => 'Mulai Rp ${_format.format(base)}';
}