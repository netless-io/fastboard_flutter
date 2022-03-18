import 'package:fastboard_flutter/src/ui/fast_base_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fast_icons.dart';

class FastToolBoxExpand extends StatefulWidget {
  const FastToolBoxExpand({Key? key, bool}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FastToolBoxExpandState();
  }
}

class FastToolBoxExpandState extends State<FastToolBoxExpand> {
  @override
  Widget build(BuildContext context) {
    return FastContainer(
        child: Column(
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
