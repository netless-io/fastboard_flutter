import 'package:flutter/material.dart';

import '../controller.dart';
import '../types/fast_redo_undo_count.dart';
import 'fast_base_ui.dart';
import 'fast_gap.dart';
import 'fast_icons.dart';

class FastRedoUndoWidget extends FastRoomControllerWidget {
  const FastRedoUndoWidget(FastRoomController controller, {Key? key})
      : super(controller, key: key);

  @override
  State<StatefulWidget> createState() {
    return FastRedoUndoState();
  }
}

class FastRedoUndoState extends FastRoomControllerState<FastRedoUndoWidget> {
  late FastRedoUndoCount redoUndoCount;

  @override
  void initState() {
    super.initState();
    redoUndoCount = widget.controller.value.redoUndoCount;
  }

  @override
  Widget build(BuildContext context) {
    return FastContainer(
        child: Row(
      children: [
        InkWell(
          child: FastIcons.undo,
          onTap: redoUndoCount.undo != 0 ? _onUndoTap : null,
        ),
        SizedBox(width: FastGap.gap_1),
        InkWell(
          child: FastIcons.redo,
          onTap: redoUndoCount.redo != 0 ? _onRedoTap : null,
        ),
      ],
    ));
  }

  void _onUndoTap() {
    widget.controller.undo();
  }

  void _onRedoTap() {
    widget.controller.redo();
  }

  @override
  void calculateState() {
    redoUndoCount = widget.controller.value.redoUndoCount;
  }
}
