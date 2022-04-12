import 'package:fastboard_flutter/src/widgets/fast_gap.dart';
import 'package:flutter/material.dart';

import '../controller.dart';
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
          SizedBox(width: FastGap.gap_1),
          Text(indicate),
          SizedBox(width: FastGap.gap_1),
          InkWell(
            child: FastIcons.pageNext,
            onTap: () => {widget.controller.nextPage()},
          ),
          SizedBox(width: FastGap.gap_1),
          InkWell(
            child: FastIcons.pageAdd,
            onTap: () => {widget.controller.addPage()},
          ),
        ],
      ),
    );
  }
}
