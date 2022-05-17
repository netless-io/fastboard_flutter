import 'dart:async';

import 'package:fastboard_flutter/fastboard_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'page.dart';
import 'widgets.dart';

class CustomLayoutPage extends FastExamplePage {
  const CustomLayoutPage()
      : super(
          const Icon(Icons.space_dashboard_rounded),
          'Custom Layout',
        );

  @override
  Widget build(BuildContext context) {
    return const CustomLayoutBody();
  }
}

class CustomLayoutBody extends StatefulWidget {
  const CustomLayoutBody();

  @override
  State<StatefulWidget> createState() {
    return CustomLayoutBodyState();
  }
}

class CustomLayoutBodyState extends State<CustomLayoutBody> {
  Completer<FastRoomController> completerController = Completer();

  static const String APP_ID = '283/VGiScM9Wiw2HJg';
  static const String ROOM_UUID = "9e441760c09711ec9b6bd3c11300c55c";
  static const String ROOM_TOKEN =
      "WHITEcGFydG5lcl9pZD15TFExM0tTeUx5VzBTR3NkJnNpZz1jNmU1ZDg0YmExYmU4YTY5MGViMDhkM2YyZGM1MzI2ZWE0M2YxNmYwOmFrPXlMUTEzS1N5THlXMFNHc2QmY3JlYXRlX3RpbWU9MTY1MDQ1MTc5NzIyNSZleHBpcmVfdGltZT0xNjgxOTg3Nzk3MjI1Jm5vbmNlPTE2NTA0NTE3OTcyMjUwMCZyb2xlPXJvb20mcm9vbUlkPTllNDQxNzYwYzA5NzExZWM5YjZiZDNjMTEzMDBjNTVjJnRlYW1JZD05SUQyMFBRaUVldTNPNy1mQmNBek9n";
  static const String UNIQUE_CLIENT_ID = "123456";

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FastRoomView(
        fastRoomOptions: FastRoomOptions(
          appId: APP_ID,
          uuid: ROOM_UUID,
          token: ROOM_TOKEN,
          uid: UNIQUE_CLIENT_ID,
          writable: true,
          fastRegion: FastRegion.cn_hz,
        ),
        useDarkTheme: false,
        onFastRoomCreated: onFastRoomCreated,
        builder: customControllerBuilder,
      ),
      FutureBuilder<FastRoomController>(
          future: completerController.future,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Positioned(
                    child: CloudTestWidget(controller: snapshot.data!),
                  )
                : Container();
          }),
      Positioned(
        child: InkWell(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        left: 24,
        top: 24,
      ),
    ]);
  }

  Widget customControllerBuilder(
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
          right: FastGap.gap_3,
        ),
        FastToolBoxExpand(controller),
        FastStateHandlerView(controller),
      ],
    );
  }

  Future<void> onFastRoomCreated(FastRoomController controller) async {
    completerController.complete(controller);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    super.dispose();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
  }
}
