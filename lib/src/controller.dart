import 'package:fastboard_flutter/src/fastboard.dart';
import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

class FastboardController {
  WhiteSdk whiteSdk;

  FastboardController(this.whiteSdk);

  Future<FastRoomController> joinRoom(FastRoomOptions fastRoomOptions) async {
    var whiteRoom =
        await whiteSdk.joinRoom(options: fastRoomOptions.roomOptions);
    return FastRoomController(whiteRoom);
  }

  void dispose() {}
}

class FastRoomController {
  WhiteRoom whiteRoom;

  FastRoomController(this.whiteRoom);
}

class FastReplayController {}
