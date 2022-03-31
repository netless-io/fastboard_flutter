import 'package:flutter/material.dart';

import '../controller.dart' show FastRoomController;
import 'fast_base_ui.dart';
import 'fast_icons.dart';

/// display page indicate
class FastPageIndicator extends FastRoomControllerWidget {
  const FastPageIndicator(FastRoomController controller, {Key? key})
      : super(controller, key: key);

  @override
  State<StatefulWidget> createState() {
    return FastPageIndicatorState();
  }
}

class FastPageIndicatorState
    extends FastRoomControllerState<FastPageIndicator> {
  FastPageIndicatorState() : super();

  String indicate = " / ";

  @override
  void calculateState() {
    var fastRoomValue = widget.controller.value;
    var pageState = fastRoomValue.roomState.pageState;
    if (pageState != null) {
      indicate = "${pageState.index + 1}/${pageState.length}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FastContainer(
      child: Row(
        children: [
          InkWell(
            child: FastIcons.pagePrev,
            onTap: () => {widget.controller.prevPage()},
          ),
          const SizedBox(width: 4),
          Text(indicate),
          const SizedBox(width: 4),
          InkWell(
            child: FastIcons.pageNext,
            onTap: () => {widget.controller.nextPage()},
          ),
          const SizedBox(width: 4),
          InkWell(
            child: FastIcons.pageAdd,
            onTap: () => {widget.controller.addPage()},
          ),
        ],
      ),
    );
  }
}
