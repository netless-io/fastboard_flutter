import 'package:fastboard_flutter/src/fastboard_models.dart';
import 'package:fastboard_flutter/src/ui/fast_page_indicator.dart';
import 'package:fastboard_flutter/src/ui/fast_tool_box.dart';
import 'package:fastboard_flutter/src/ui/fast_undo_redo.dart';
import 'package:flutter/cupertino.dart';
import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

abstract class FastboardController {
  const FastboardController();

  List<Widget> buildView(BuildContext context);
}

class FastRoomController extends ValueNotifier<RoomState>
    implements FastboardController {
  WhiteSdk? whiteSdk;
  WhiteRoom? whiteRoom;

  FastRoomOptions fastRoomOptions;

  FastRoomController(this.fastRoomOptions) : super(RoomState());

  joinRoom() async {
    whiteRoom = await whiteSdk?.joinRoom(
      options: fastRoomOptions.roomOptions,
      onRoomPhaseChanged: _onRoomPhaseChanged,
      onRoomStateChanged: _onRoomStateChanged,
    );
  }

  void _onRoomStateChanged(RoomState newState) {
    value = newState;
  }

  void cleanScene() {
    whiteRoom?.cleanScene(false);
  }

  void addPage() {}

  void prevPage() {}

  void nextPage() {}

  @override
  List<Widget> buildView(BuildContext context) {
    return [
      WhiteboardView(
        options: fastRoomOptions.whiteOptions,
        onSdkCreated: onSdkCreated,
      ),
      Positioned(
        child: FastPageIndicator(this),
        bottom: 12.0,
      ),
      const Positioned(
        child: FastRedoUndoWidget(),
        bottom: 12.0,
        left: 12.0,
      ),
      const Positioned(
        child: FastToolBoxExpand(),
        left: 12.0,
      ),
    ];
  }

  Future<void> onSdkCreated(WhiteSdk whiteSdk) async {
    this.whiteSdk = whiteSdk;
    await joinRoom();
  }

  void _onRoomPhaseChanged(String phase) {

  }
}

class FastReplayController {}
