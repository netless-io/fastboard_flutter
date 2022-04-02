import 'package:fastboard_flutter/src/types/fast_redo_undo_count.dart';
import 'package:flutter/foundation.dart';
import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

// all fast room state, include isReady, writable, roomPhase and roomState.
class FastRoomValue {
  FastRoomValue({
    this.isReady = false,
    this.writable = false,
    this.roomPhase = RoomPhase.connecting,
    this.redoUndoCount = const FastRedoUndoCount(),
    RoomState? roomState,
  }) : roomState = roomState ?? RoomState();

  FastRoomValue.uninitialized(bool writable) : this(writable: writable);

  final bool isReady;

  final bool writable;

  final RoomState roomState;

  final String roomPhase;

  final FastRedoUndoCount redoUndoCount;

  /// Returns a new instance that has the same values as this current instance,
  /// except for any overrides passed in as arguments to [copyWith].
  FastRoomValue copyWith({
    bool? isReady,
    bool? writable,
    RoomState? roomState,
    String? roomPhase,
    FastRedoUndoCount? redoUndoCount,
  }) {
    return FastRoomValue(
      isReady: isReady ?? this.isReady,
      writable: writable ?? this.writable,
      roomPhase: roomPhase ?? this.roomPhase,
      roomState: roomState ?? this.roomState,
      redoUndoCount: redoUndoCount ?? this.redoUndoCount,
    );
  }

  @override
  String toString() {
    return '${objectRuntimeType(this, 'FastRoomValue')}('
        'writable: $writable, '
        'roomPhase: $roomPhase, '
        'roomState: $roomState, ';
  }
}
