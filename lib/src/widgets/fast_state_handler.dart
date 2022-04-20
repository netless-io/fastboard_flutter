import 'package:fastboard_flutter/src/widgets/fast_resource_provider.dart';
import 'package:flutter/material.dart';
import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

import '../controller.dart';
import 'fast_base_ui.dart';
import 'fast_gap.dart';

class FastStateHandlerWidget extends FastRoomControllerWidget {
  const FastStateHandlerWidget(FastRoomController controller, {Key? key})
      : super(controller, key: key);

  @override
  State<StatefulWidget> createState() {
    return FastStateHandlerState();
  }
}

class FastStateHandlerState
    extends FastRoomControllerState<FastStateHandlerWidget> {
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
    switch (state) {
      case RoomHandlerState.loading:
        return Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(
              FastResourceProvider.themeData.mainColor,
            ),
          )),
        );
      case RoomHandlerState.connected:
        return Container();
      case RoomHandlerState.error:
        return Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: FastContainer(
                child: InkWell(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: FastGap.gap_1_5),
                      child: Text("retry")),
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
