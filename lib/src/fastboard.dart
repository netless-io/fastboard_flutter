import 'package:flutter/widgets.dart';
import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

import 'controller.dart';
import 'types/types.dart';
import 'widgets/default_builder.dart';
import 'widgets/widgets.dart';

/// 回调房间控制
typedef FastRoomCreatedCallback = void Function(FastRoomController controller);

/// 用于用户自定义控制组件
typedef ControllerWidgetBuilder = Widget Function(
  BuildContext context,
  FastRoomController controller,
);

class FastRoomView extends StatefulWidget {
  const FastRoomView({
    Key? key,
    required this.fastRoomOptions,
    this.theme,
    this.darkTheme,
    this.useDarkTheme = false,
    this.onFastRoomCreated,
    this.builder = defaultControllerBuilder,
  }) : super(key: key);

  /// light theme data
  final FastThemeData? theme;

  /// dark theme data
  final FastThemeData? darkTheme;

  final bool useDarkTheme;

  /// 房间配置信息
  final FastRoomOptions fastRoomOptions;

  /// 加入成功回调
  final FastRoomCreatedCallback? onFastRoomCreated;

  final ControllerWidgetBuilder builder;

  @override
  State<StatefulWidget> createState() {
    return FastRoomViewState();
  }
}

class FastRoomViewState extends State<FastRoomView> {
  late FastRoomController controller;

  @override
  void initState() {
    super.initState();
    controller = FastRoomController(widget.fastRoomOptions);
  }

  @override
  Widget build(BuildContext context) {
    FastGap.initContext(context);
    var themeData = _obtainThemeData();

    var whiteOptions = widget.fastRoomOptions.whiteOptions.copyWith(
      backgroundColor: themeData.backgroundColor,
    );

    return ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          children: [
            WhiteboardView(
              options: whiteOptions,
              onSdkCreated: (sdk) async {
                await controller.onSdkCreated(sdk);
                widget.onFastRoomCreated?.call(controller);
              },
            ),
            FastTheme(
                data: themeData,
                child: Builder(builder: (context) {
                  return widget.builder(context, controller);
                }))
          ],
        ));
  }

  FastThemeData _obtainThemeData() {
    return widget.useDarkTheme
        ? widget.darkTheme ?? FastThemeData.dark()
        : widget.theme ?? FastThemeData.light();
  }

  @override
  void didUpdateWidget(FastRoomView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateWhiteIfNeed(oldWidget);
  }

  void _updateWhiteIfNeed(FastRoomView oldWidget) {
    if (oldWidget.useDarkTheme != widget.useDarkTheme) {
      var themeData = _obtainThemeData();
      controller.whiteSdk?.setBackgroundColor(themeData.backgroundColor);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
