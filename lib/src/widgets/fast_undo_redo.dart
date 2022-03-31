import 'package:flutter/material.dart';

import '../controller.dart';
import 'fast_base_ui.dart';
import 'fast_icons.dart';

class FastRedoUndoWidget extends FastRoomControllerWidget {
  const FastRedoUndoWidget(FastRoomController controller, {Key? key})
      : super(controller, key: key);

  @override
  State<StatefulWidget> createState() {
    return FastRedoUndoState();
  }
}

class FastRedoUndoState extends State<FastRedoUndoWidget> {
  @override
  Widget build(BuildContext context) {
    return FastContainer(
        child: Row(
      children: [
        InkWell(
          child: FastIcons.undo,
          onTap: () => {_onUndoTap()},
        ),
        const SizedBox(width: 4),
        InkWell(
          child: FastIcons.redo,
          onTap: () => {_onRedoTap()},
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
}
