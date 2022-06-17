import 'dart:ui';

import 'package:fastboard_flutter/fastboard_flutter.dart';

class FastRoomEvent<T extends Object> {
  final T value;

  FastRoomEvent(this.value);
}

/// 处理 overlay 的逻辑
class OverlayChangedEvent extends FastRoomEvent<int> {
  static const int noOverlay = 0;
  static const int subAppliances = 1;

  OverlayChangedEvent(int value) : super(value);
}

class FastErrorEvent extends FastRoomEvent<WhiteException> {
  FastErrorEvent(WhiteException exception) : super(exception);
}

class SizeChangedEvent extends FastRoomEvent<Size> {
  SizeChangedEvent(Size size) : super(size);
}