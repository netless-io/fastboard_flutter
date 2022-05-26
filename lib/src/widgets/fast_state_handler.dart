import 'package:fastboard_flutter/src/translations/fastboard.i18n.dart';
import 'package:fastboard_flutter/src/types/fast_theme_data.dart';
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
  String roomPhase = RoomPhase.connecting;
  WhiteErrorCode? errorCode;

  bool get showExit =>
      errorCode == WhiteErrorCode.invalidAppId ||
      errorCode == WhiteErrorCode.invalidRoomToken ||
      errorCode == WhiteErrorCode.sdkInitFailed;

  bool get showRetry =>
      errorCode == WhiteErrorCode.joinRoomError ||
      errorCode == WhiteErrorCode.unknown;

  @override
  void initState() {
    super.initState();
    widget.controller.onError().listen((event) {
      setState(() {
        errorCode = event.value.code;
      });
    });
  }

  @override
  void calculateState() {
    var value = widget.controller.value;
    roomPhase = value.roomPhase;
  }

  @override
  Widget build(BuildContext context) {
    var themeData = FastTheme.of(context);

    if (roomPhase == RoomPhase.connecting ||
        roomPhase == RoomPhase.reconnecting) {
      return buildLoading(themeData);
    }
    if (roomPhase == RoomPhase.connected) {
      return Container();
    }
    return buildError(context);
  }

  Container buildLoading(FastThemeData themeData) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: themeData.backgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(
              themeData.mainColor,
            ),
          ),
          SizedBox(height: FastGap.gap_2),
          FastText("Loading".i18n)
        ],
      ),
    );
  }

  Container buildError(BuildContext context) {
    var themeData = FastTheme.of(context);
    var describe = showRetry ? 'Room Error' : 'Init Sdk Error';

    return Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: themeData.backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FastText(describe.i18n),
            if (showRetry) SizedBox(height: FastGap.gap_2),
            if (showRetry)
              FastContainer(
                child: InkWell(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: FastGap.gap_1_5),
                      child: FastText("Retry".i18n)),
                  onTap: _onReconnect,
                ),
              ),
          ],
        ));
  }

  void _onReconnect() {
    widget.controller.reconnect();
  }
}
