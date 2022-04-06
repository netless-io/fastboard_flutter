// ignore_for_file: constant_identifier_names

import 'package:fastboard_flutter/fastboard_flutter.dart';

enum FastRegion {
  /// `cn_hz`：中国杭州。
  /// <p>
  /// 该数据中心为其他数据中心服务区未覆盖的地区提供服务。
  cn_hz,

  /// `us_sv`：美国硅谷。
  /// <p>
  /// 该数据中心为北美洲、南美洲地区提供服务。
  us_sv,

  /// `sg`：新加坡。
  /// <p>
  /// 该数据中心为新加坡、东亚、东南亚地区提供服务。
  sg,

  /// `in_mum`：印度孟买。
  /// <p>
  /// 该数据中心为印度地区提供服务。
  in_mum,

  /// `gb_lon`：英国伦敦。
  /// <p>
  /// 该数据中心为欧洲地区提供服务。
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
