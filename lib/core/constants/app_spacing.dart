/// Design tokens spacing dan border radius untuk aplikasi KKOS.
///
/// Semua spacing menggunakan kelipatan 4 (8pt grid system).
/// DILARANG menulis nilai hardcoded di widget. Selalu gunakan
/// token dari class ini.
abstract final class AppSpacing {
  // Spacing
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  // Border Radius
  static const double radiusSm = 6;
  static const double radiusMd = 10;
  static const double radiusLg = 14;
  static const double radiusFull = 999;

  // Icon Size
  static const double iconSm = 16;
  static const double iconMd = 20;
  static const double iconLg = 24;
  static const double iconXl = 32;
  static const double iconEmptyState = 64;

  // Elevation
  static const double elevationNone = 0;
  static const double elevationLow = 1;
  static const double elevationMedium = 2;

  // Shadow (maksimal blurRadius 8 sesuai design system)
  static const double shadowBlurSoft = 4;
  static const double shadowBlurMedium = 8;
  static const double shadowOffsetY = 2;
}
