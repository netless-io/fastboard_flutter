import 'package:flutter/widgets.dart';

class FastGap {
  static late double _width;
  static late double _height;
  static late bool large;

  static void initContext(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    large = _width > 500 && _height > 500;
  }

  static double get gapMin => large ? 1 : 0.5;

  static double get gap_0_2_5 => large ? 1.5 : 1.0;

  static double get gap_0_5 => large ? 3.0 : 2.0;

  static double get gap_1 => large ? 6.0 : 4.0;

  static double get gap_1_5 => large ? 9.0 : 6.0;

  static double get gap_2 => large ? 12.0 : 8.0;

  static double get gap_3 => large ? 18.0 : 12.0;

  static double get gap_4 => large ? 24.0 : 16.0;

  static double get gap_5 => large ? 30.0 : 20.0;

  static double get gap_6 => large ? 32.0 : 24.0;

  static double get gap_8 => large ? 48.0 : 32.0;

  static double get subToolboxWidth => large ? 180.0 : 120.0;
}
