import 'package:fastboard_flutter/fastboard_flutter.dart';
import 'package:fastboard_flutter_example/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  QuickStartBodyState();

  FastboardController? controller;
  FastRoomController? fastRoomController;

  static const String APP_ID = '283/VGiScM9Wiw2HJg';
  static const String ROOM_UUID = "d4184790ffd511ebb9ebbf7a8f1d77bd";
  static const String ROOM_TOKEN =
      "NETLESSROOM_YWs9eTBJOWsxeC1IVVo4VGh0NyZub25jZT0xNjI5MjU3OTQyNTM2MDAmcm9sZT0wJnNpZz1lZDdjOGJiY2M4YzVjZjQ5NDU5NmIzZGJiYzQzNDczNDJmN2NjYTAxMThlMTMyOWVlZGRmMjljNjE1NzQ5ZWFkJnV1aWQ9ZDQxODQ3OTBmZmQ1MTFlYmI5ZWJiZjdhOGYxZDc3YmQ";
  static const String UNIQUE_CLIENT_ID = "123456";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FastboardView(
        fastRoomOptions: FastRoomOptions(
          appId: APP_ID,
          uuid: ROOM_UUID,
          token: ROOM_TOKEN,
          uid: UNIQUE_CLIENT_ID,
          writable: true,
          region: Region.cn_hz,
        ),
        onFastRoomCreated: onFastRoomCreated,
      ),
    ]);
  }

  Future<void> onFastRoomCreated(FastRoomController controller) async {}

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
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
