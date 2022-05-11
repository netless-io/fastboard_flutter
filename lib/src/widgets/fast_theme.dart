import 'package:fastboard_flutter/src/types/fast_theme_data.dart';
import 'package:flutter/widgets.dart';

class FastTheme extends InheritedWidget {
  FastTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final FastThemeData data;

  static FastTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FastTheme>();
  }

  @override
  bool updateShouldNotify(FastTheme old) {
    return old.data != data;
  }
}
