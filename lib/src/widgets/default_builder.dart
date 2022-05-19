import 'package:flutter/widgets.dart';

import '../controller.dart';
import 'widgets.dart';

Widget defaultControllerBuilder(
  BuildContext context,
  FastRoomController controller,
) {
  return Stack(
    alignment: Alignment.center,
    children: [
      FastOverlayHandlerView(controller),
      Positioned(
        child: FastPageIndicator(controller),
        bottom: FastGap.gap_3,
      ),
      Positioned(
        child: Row(
          children: [
            FastRedoUndoView(controller),
            SizedBox(width: FastGap.gap_2),
            FastZoomView(controller),
          ],
        ),
        bottom: FastGap.gap_3,
        left: FastGap.gap_3,
      ),
      FastToolBoxExpand(controller),
      FastStateHandlerView(controller),
    ],
  );
}
