import 'package:fastboard_flutter/fastboard_flutter.dart';
import 'package:flutter/widgets.dart';

import 'widgets/fast_page_indicator.dart';
import 'widgets/fast_tool_box.dart';
import 'widgets/fast_undo_redo.dart';

typedef FastRoomCreatedCallback = void Function(FastRoomController controller);

typedef ControllerWidgetBuilder = Widget Function(
  BuildContext context,
  FastRoomController controller,
);

class FastRoomWidget extends StatefulWidget {
  final ControllerWidgetBuilder? controllerWidgetBuilder;

  const FastRoomWidget({
    Key? key,
    required this.fastRoomOptions,
    this.fastStyle,
    this.onFastRoomCreated,
    this.controllerWidgetBuilder,
  }) : super(key: key);

  final FastRoomOptions fastRoomOptions;
  final FastStyle? fastStyle;
  final FastRoomCreatedCallback? onFastRoomCreated;

  @override
  State<StatefulWidget> createState() {
    return FastRoomWidgetState();
  }
}

class FastRoomWidgetState extends State<FastRoomWidget> {
  late FastRoomController controller;
  late WhiteSdk whiteSdk;

  @override
  void initState() {
    super.initState();
    controller = FastRoomController(widget.fastRoomOptions);
  }

  @override
  Widget build(BuildContext context) {
    Widget controllerWidget;
    if (widget.controllerWidgetBuilder != null) {
      controllerWidget = widget.controllerWidgetBuilder!(context, controller);
    } else {
      controllerWidget = Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: FastPageIndicator(controller),
            bottom: 12.0,
          ),
          Positioned(
            child: FastRedoUndoWidget(controller),
            bottom: 12.0,
            left: 12.0,
          ),
          Positioned(
            child: FastToolBoxExpand(controller),
            left: 12.0,
          ),
        ],
      );
    }

    return ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          children: [
            WhiteboardView(
              options: widget.fastRoomOptions.whiteOptions,
              onSdkCreated: controller.onSdkCreated,
            ),
            controllerWidget,
          ],
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
