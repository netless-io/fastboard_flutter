import 'package:flutter/material.dart';

import '../controller.dart';
import '../types/types.dart';
import 'widgets.dart';

class FastOverlayHandler extends FastRoomControllerWidget {
  const FastOverlayHandler(
    FastRoomController controller, {
    Key? key,
    bool? expand,
  }) : super(controller, key: key);

  @override
  State<StatefulWidget> createState() {
    return FastOverlayHandlerState();
  }
}

class FastOverlayHandlerState
    extends FastRoomControllerState<FastOverlayHandler> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OverlayChangedEvent>(
      stream: widget.controller.onOverlayChanged(),
      initialData: OverlayChangedEvent(OverlayChangedEvent.noOverlay),
      builder: (
        BuildContext context,
        AsyncSnapshot<OverlayChangedEvent> snapshot,
      ) {
        if (snapshot.hasData &&
            snapshot.data!.value != OverlayChangedEvent.noOverlay) {
          return Listener(
            behavior: HitTestBehavior.translucent,
            child: Container(
              constraints: BoxConstraints.expand(),
            ),
            onPointerDown: (_) => hideOverlay(),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void calculateState() {}

  void hideOverlay() {
    widget.controller.changeOverlay(OverlayChangedEvent.noOverlay);
  }
}
