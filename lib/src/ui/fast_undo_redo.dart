import 'package:fastboard_flutter/src/ui/fast_base_ui.dart';
import 'package:flutter/material.dart';

import 'fast_icons.dart';

class FastRedoUndoWidget extends StatefulWidget {
  const FastRedoUndoWidget({Key? key, bool}) : super(key: key);

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
          onTap: () => {},
        ),
        const SizedBox(width: 4),
        InkWell(
          child: FastIcons.redo,
          onTap: () => {},
        ),
      ],
    ));
  }
}
