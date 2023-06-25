import 'dart:async';

import 'package:fastboard_flutter/fastboard_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';
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
  Completer<FastRoomController> controllerCompleter = Completer();

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      LayoutBuilder(builder: (context, constraints) {
        return FastRoomView(
          fastRoomOptions: FastRoomOptions(
              appId: APP_ID,
              uuid: ROOM_UUID,
              token: ROOM_TOKEN,
              uid: UNIQUE_CLIENT_ID,
              writable: true,
              fastRegion: FastRegion.cn_hz,
              containerSizeRatio: constraints.maxHeight / constraints.maxWidth),
          useDarkTheme: false,
          onFastRoomCreated: onFastRoomCreated,
          builder: customBuilder,
        );
      }),
      FutureBuilder<FastRoomController>(
          future: controllerCompleter.future,
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

  Widget customBuilder(
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
    controllerCompleter.complete(controller);
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
