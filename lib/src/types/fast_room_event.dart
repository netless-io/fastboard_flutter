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
