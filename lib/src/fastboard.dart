import 'package:fastboard_flutter/src/controller.dart';
import 'package:fastboard_flutter/src/ui/fast_page_indicator.dart';
import 'package:fastboard_flutter/src/ui/fast_undo_redo.dart';
import 'package:flutter/cupertino.dart';
import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

import 'fastboard_models.dart';

typedef FastboardCreatedCallback = void Function(
    FastboardController controller);

typedef FastRoomCreatedCallback = void Function(FastRoomController controller);

class FastboardView extends StatefulWidget {
  const FastboardView({
    Key? key,
    this.fastRoomOptions,
    this.fastReplayOptions,
    this.onFastRoomCreated,
    this.fastStyle,
  }) : super(key: key);

  // final FastboardCreatedCallback? onFastboardCreated = null;
  final FastRoomCreatedCallback? onFastRoomCreated;
  final FontStyle? fastStyle;
  final FastRoomOptions? fastRoomOptions;
  final FastReplayOptions? fastReplayOptions;

  @override
  State<StatefulWidget> createState() {
    return FastboardViewState();
  }
}

class FastboardViewState extends State<FastboardView> {
  late FastboardController fastboardController;
  FastRoomController? fastRoomController;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: const [
          // WhiteboardView(
          //   options: widget.fastRoomOptions!.whiteOptions,
          //   onSdkCreated: onSdkCreated,
          // ),
          Positioned(
            child: FastPageIndicator(),
            bottom: 12.0,
          ),
          Positioned(
            child: FastRedoUndoWidget(),
            bottom: 12.0,
            left: 12.0,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> onSdkCreated(WhiteSdk whiteSdk) async {
    fastboardController = FastboardController(whiteSdk);
    fastRoomController =
        await fastboardController.joinRoom(widget.fastRoomOptions!);
    widget.onFastRoomCreated?.call(fastRoomController!);
  }
}
