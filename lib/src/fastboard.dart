import 'package:fastboard_flutter/src/controller.dart';
import 'package:fastboard_flutter/src/ui/white_page_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

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
  final FastStyle? fastStyle;
  final FastRoomOptions? fastRoomOptions;
  final FastReplayOptions? fastReplayOptions;

  @override
  State<StatefulWidget> createState() {
    return FastboardViewState();
  }
}

class FastboardViewState extends State<FastboardView> {
  late FastboardController fastboardController;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // WhiteboardView(
          //   options: widget.fastRoomOptions!.whiteOptions,
          //   onSdkCreated: onSdkCreated,
          // ),
          const Positioned(
            child: WhitePageWidget(),
            bottom: 12.0,
          )
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
    var controller =
        await fastboardController.joinRoom(widget.fastRoomOptions!);
    widget.onFastRoomCreated?.call(controller);
  }
}

class FastRoomOptions {
  WhiteOptions? _whiteOptions;

  WhiteOptions get whiteOptions =>
      _whiteOptions ?? WhiteOptions(appIdentifier: appId);

  set whiteOptions(WhiteOptions? whiteOptions) => _whiteOptions = whiteOptions;

  RoomOptions? _roomOptions;

  RoomOptions get roomOptions =>
      _roomOptions ??
      RoomOptions(
        uuid: uuid,
        roomToken: token,
        uid: uid,
        isWritable: writable,
        region: region,
      );

  set roomOptions(RoomOptions? roomOptions) => _roomOptions = roomOptions;

  final String appId;
  final String uuid;
  final String token;
  final String uid;
  final bool writable;
  final String region;

  FastRoomOptions({
    required this.appId,
    required this.uuid,
    required this.token,
    required this.uid,
    required this.writable,
    required this.region,
    WhiteOptions? whiteOptions,
    RoomOptions? roomOptions,
  }) {
    _whiteOptions = whiteOptions;
  }
}

class FastReplayOptions {}

class FastStyle {
  Color? canvasColor;
  bool darkMode;

  FastStyle({
    this.canvasColor,
    this.darkMode = false,
  });
}
