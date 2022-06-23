// ignore_for_file: constant_identifier_names

import 'package:fastboard_flutter/fastboard_flutter.dart';

enum FastRegion {
  /// Hangzhou, China
  /// which provides services to areas not covered by other data centers.
  cn_hz,

  /// Silicon Valley, United States
  /// which provides services to North America and South America.
  us_sv,

  /// Singapore
  /// which provides services to Singapore, East Asia, and Southeast Asia.
  sg,

  /// Mumbai, India
  /// which provides services to India.
  in_mum,

  /// London, United Kingdom
  /// which provides services to Europe.
  gb_lon,
}

extension FastRegionExtensions on FastRegion {
  String toRegion() {
    switch (this) {
      case FastRegion.cn_hz:
        return Region.cn_hz;
      case FastRegion.us_sv:
        return Region.us_sv;
      case FastRegion.sg:
        return Region.sg;
      case FastRegion.in_mum:
        return Region.in_mum;
      case FastRegion.gb_lon:
        return Region.gb_lon;
    }
  }
}
