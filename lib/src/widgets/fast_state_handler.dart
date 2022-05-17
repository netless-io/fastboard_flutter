import 'package:flutter/material.dart';
import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

import '../controller.dart';
import 'widgets.dart';

/// display the room loading, error and support a ui to reconnect
class FastStateHandlerView extends FastRoomControllerWidget {
  const FastStateHandlerView(
    FastRoomController controller, {
    Key? key,
  }) : super(controller, key: key);

  @override
  State<StatefulWidget> createState() {
    return FastStateHandlerState();
  }
}

class FastStateHandlerState
    extends FastRoomControllerState<FastStateHandlerView> {
  RoomHandlerState state = RoomHandlerState.loading;

  @override
  void calculateState() {
    var value = widget.controller.value;
    switch (value.roomPhase) {
      case RoomPhase.connecting:
      case RoomPhase.reconnecting:
        state = RoomHandlerState.loading;
        break;
      case RoomPhase.connected:
        state = RoomHandlerState.connected;
        break;
      case RoomPhase.disconnected:
        state = RoomHandlerState.error;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeData = FastTheme.of(context);

    switch (state) {
      case RoomHandlerState.loading:
        return Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: themeData.backgroundColor,
          ),
          child: Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(
              themeData.mainColor,
            ),
          )),
        );
      case RoomHandlerState.connected:
        return Container();
      case RoomHandlerState.error:
        return Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: themeData.backgroundColor,
            ),
            child: Center(
              child: FastContainer(
                child: InkWell(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: FastGap.gap_1_5),
                      child: FastText("retry")),
                  onTap: _onReconnect,
                ),
              ),
            ));
    }
  }

  void _onReconnect() {
    widget.controller.reconnect();
  }
}

enum RoomHandlerState {
  loading,
  connected,
  error,
}
