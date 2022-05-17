import 'package:flutter/widgets.dart';

import '../types/fast_theme_data.dart';

class FastTheme extends InheritedWidget {
  FastTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final FastThemeData data;

  static FastThemeData of(BuildContext context) {
    final FastTheme? fastTheme = context.dependOnInheritedWidgetOfExactType<FastTheme>();
    return fastTheme?.data ?? FastThemeData.light();
  }

  @override
  bool updateShouldNotify(FastTheme oldWidget) {
    return oldWidget.data != data;
  }
}
