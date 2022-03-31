import 'package:flutter/foundation.dart';

@immutable
class FastRedoUndoCount {
  final int redo;
  final int undo;

  const FastRedoUndoCount({
    this.redo = 0,
    this.undo = 0,
  });

  const FastRedoUndoCount.initialized() : this();

  FastRedoUndoCount copyWith({
    int? redoCount,
    int? undoCount,
  }) {
    return FastRedoUndoCount(
      redo: redoCount ?? redo,
      undo: undoCount ?? undo,
    );
  }
}
