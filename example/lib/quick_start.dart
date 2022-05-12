import 'package:fastboard_flutter/fastboard_flutter.dart';
import 'package:fastboard_flutter_example/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets.dart';

class QuickStartPage extends FastExamplePage {
  const QuickStartPage() : super(const Icon(Icons.ac_unit), 'Quick Start');

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
  FastRoomController? controller;

  static const String APP_ID = '283/VGiScM9Wiw2HJg';
  static const String ROOM_UUID = "9e441760c09711ec9b6bd3c11300c55c";
  static const String ROOM_TOKEN =
      "WHITEcGFydG5lcl9pZD15TFExM0tTeUx5VzBTR3NkJnNpZz1jNmU1ZDg0YmExYmU4YTY5MGViMDhkM2YyZGM1MzI2ZWE0M2YxNmYwOmFrPXlMUTEzS1N5THlXMFNHc2QmY3JlYXRlX3RpbWU9MTY1MDQ1MTc5NzIyNSZleHBpcmVfdGltZT0xNjgxOTg3Nzk3MjI1Jm5vbmNlPTE2NTA0NTE3OTcyMjUwMCZyb2xlPXJvb20mcm9vbUlkPTllNDQxNzYwYzA5NzExZWM5YjZiZDNjMTEzMDBjNTVjJnRlYW1JZD05SUQyMFBRaUVldTNPNy1mQmNBek9n";
  static const String UNIQUE_CLIENT_ID = "123456";

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FastRoomWidget(
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
      ),
      if (controller != null)
        Positioned(child: CloudTestWidget(controller: controller!)),
    ]);
  }

  Future<void> onFastRoomCreated(FastRoomController controller) async {
    setState(() {
      this.controller = controller;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
