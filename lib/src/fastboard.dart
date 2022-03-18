import 'package:fastboard_flutter/src/controller.dart';
import 'package:flutter/cupertino.dart';

import 'fastboard_models.dart';

typedef FastRoomCreatedCallback = void Function(FastRoomController controller);

class FastboardView extends StatefulWidget {
  const FastboardView({
    Key? key,
    this.fastRoomOptions,
    this.fastReplayOptions,
    this.fastStyle,
  }) : super(key: key);

  final FontStyle? fastStyle;
  final FastRoomOptions? fastRoomOptions;
  final FastReplayOptions? fastReplayOptions;

  @override
  State<StatefulWidget> createState() {
    return FastboardViewState();
  }
}

class FastboardViewState extends State<FastboardView> {
  late FastboardController controller;

  @override
  void initState() {
    super.initState();
    if (widget.fastRoomOptions != null) {
      controller = FastRoomController(widget.fastRoomOptions!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: controller.buildView(context),
        ));
  }
}
