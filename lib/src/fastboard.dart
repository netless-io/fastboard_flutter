import 'package:flutter/widgets.dart';
import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

import 'controller.dart';
import 'types/types.dart';
import 'widgets/widgets.dart';

/// 回调房间控制
typedef FastRoomCreatedCallback = void Function(FastRoomController controller);

/// 用于用户自定义控制组件
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

  /// 房间配置信息
  final FastRoomOptions fastRoomOptions;

  /// 主题模式配置
  final FastStyle? fastStyle;

  /// 加入成功回调
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
    var builder = widget.controllerWidgetBuilder ?? defaultControllerBuilder;
    return ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          children: [
            WhiteboardView(
              options: widget.fastRoomOptions.whiteOptions,
              onSdkCreated: controller.onSdkCreated,
            ),
            builder(context, controller),
          ],
        ));
  }

  Widget defaultControllerBuilder(
    BuildContext context,
    FastRoomController controller,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FastOverlayHandler(controller),
        Positioned(
          child: FastPageIndicator(controller),
          bottom: 12.0,
        ),
        Positioned(
          child: Row(
            children: [
              FastRedoUndoWidget(controller),
              SizedBox(width: 8),
              FastZoomWidget(controller),
            ],
          ),
          bottom: 12.0,
          left: 12.0,
        ),
        FastToolBoxExpand(controller),
        FastStateHandlerWidget(controller),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
