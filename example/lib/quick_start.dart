import 'dart:async';

import 'package:fastboard_flutter/fastboard_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';
import 'page.dart';
import 'widgets.dart';

class QuickStartPage extends FastExamplePage {
  const QuickStartPage()
      : super(
          const Icon(Icons.rocket_launch_rounded),
          'Quick Start',
        );

  @override
  Widget build(BuildContext context) {
    return const QuickStartBody();
  }
}

class QuickStartBody extends StatefulWidget {
  const QuickStartBody();

  @override
  State<StatefulWidget> createState() {
    return QuickStartBodyState();
  }
}

class QuickStartBodyState extends State<QuickStartBody> {
  Completer<FastRoomController> completerController = Completer();

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
          containerSizeRatio: null,
        ),
        useDarkTheme: false,
        onFastRoomCreated: onFastRoomCreated,
      ),
      FutureBuilder<FastRoomController>(
          future: completerController.future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Positioned(
                child: CloudTestWidget(controller: snapshot.data!),
              );
            } else {
              return Container();
            }
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
