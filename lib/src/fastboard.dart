import 'package:fastboard_flutter/src/widgets/flutter_after_layout.dart';
import 'package:flutter/widgets.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

import 'controller.dart';
import 'types/types.dart';
import 'widgets/default_builder.dart';
import 'widgets/widgets.dart';

/// 回调房间控制
typedef FastRoomCreatedCallback = void Function(FastRoomController controller);

/// 用于用户自定义控制组件
typedef RoomControllerWidgetBuilder = Widget Function(
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
    this.locate,
    this.onFastRoomCreated,
    this.builder = defaultControllerBuilder,
  }) : super(key: key);

  /// light theme data
  final FastThemeData? theme;

  /// dark theme data
  final FastThemeData? darkTheme;

  /// The locale to use for the fastboard, defaults to system locale
  /// supported :
  ///   Locale("en")
  ///   Locale("zh", "CN")
  final Locale? locate;

  /// dark mode config, true for darkTheme, false for lightTheme
  final bool useDarkTheme;

  /// fast room config info
  final FastRoomOptions fastRoomOptions;

  /// room created callback
  final FastRoomCreatedCallback? onFastRoomCreated;

  final RoomControllerWidgetBuilder builder;

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
    FastGap.init(context);
    var themeData = _obtainThemeData();
    var whiteOptions = widget.fastRoomOptions.genWhiteOptions(
      backgroundColor: themeData.backgroundColor,
    );
    return I18n(
      child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: AfterLayout(
            callback: (renderAfterLayout) {
              debugPrint("room view changed: ${renderAfterLayout.size}");
              controller.updateRoomLayoutSize(renderAfterLayout.size);
            },
            child: Stack(
              children: [
                WhiteboardView(
                  options: whiteOptions,
                  onSdkCreated: (sdk) async {
                    await controller.joinRoomWithSdk(sdk);
                    widget.onFastRoomCreated?.call(controller);
                  },
                ),
                FastTheme(
                    data: themeData,
                    child: Builder(builder: (context) {
                      return widget.builder(context, controller);
                    }))
              ],
            ),
          )),
      initialLocale: widget.locate,
    );
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
