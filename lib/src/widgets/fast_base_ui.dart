import 'package:fastboard_flutter/fastboard_flutter.dart';
import 'package:fastboard_flutter/src/widgets/fast_gap.dart';
import 'package:fastboard_flutter/src/widgets/fast_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controller.dart';
import 'fast_icons.dart';

abstract class FastRoomControllerWidget extends StatefulWidget {
  final FastRoomController controller;

  const FastRoomControllerWidget(this.controller, {Key? key}) : super(key: key);
}

abstract class FastRoomControllerState<T extends FastRoomControllerWidget>
    extends State<T> {
  FastRoomControllerState() {
    listener = () {
      calculateState();
      setState(() {});
    };
  }

  late VoidCallback listener;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listener);
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(listener);
      widget.controller.addListener(listener);
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    widget.controller.removeListener(listener);
  }

  @protected
  void calculateState();
}

/// 组件容器，用于设置 Toolbox，RedoUndo 等的背景控制
class FastContainer extends StatelessWidget {
  final Widget? child;

  const FastContainer({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = FastTheme.of(context)!.data;

    return Container(
      padding: EdgeInsets.all(FastGap.gap_1),
      // TODO InkWell 点击效果的水波纹处理
      child: Material(color: Colors.transparent, child: child),
      decoration: BoxDecoration(
          color: themeData.backgroundColor,
          border: Border.fromBorderSide(BorderSide(
            width: FastGap.gapMin,
            color: themeData.borderColor,
          )),
          borderRadius: BorderRadius.circular(FastGap.gap_1)),
    );
  }
}

/// 工具箱按钮
@immutable
class FastToolboxButton extends StatelessWidget {
  final bool selected;
  final bool expandable;

  final List<Widget> icons;

  final GestureTapCallback? onTap;

  const FastToolboxButton({
    Key? key,
    this.selected = false,
    this.expandable = false,
    this.icons = const [],
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = FastTheme.of(context)!.data;

    var color = selected ? themeData.borderColor : null;
    var svgIcon = selected ? icons[1] : icons[0];

    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              FastGap.gap_1,
            )),
        child: InkWell(
          child: Stack(
            children: [
              if (expandable) FastIcons.expandable,
              svgIcon,
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

class FastIcon extends StatelessWidget {
  final bool selected;
  final List<String> icons;
  final Color? color;

  FastIcon({
    Key? key,
    required this.icons,
    this.selected = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    var themeData = FastTheme.of(context)!.data;

    return SvgPicture.asset(
      selected ? icons[1] : icons[0],
      package: "fastboard_flutter",
      width: FastGap.gap_6,
      height: FastGap.gap_6,
      color: themeData.iconColor,
    );
  }
}

/// code by [https://book.flutterchina.club/]
class AfterLayout extends SingleChildRenderObjectWidget {
  AfterLayout({
    Key? key,
    required this.callback,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderAfterLayout(callback);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderAfterLayout renderObject) {
    renderObject.callback = callback;
  }

  ///组件树布局结束后会被触发，注意，并不是当前组件布局结束后触发
  final ValueSetter<RenderAfterLayout> callback;
}

class RenderAfterLayout extends RenderProxyBox {
  RenderAfterLayout(this.callback);

  ValueSetter<RenderAfterLayout> callback;

  @override
  void performLayout() {
    super.performLayout();
    // 不能直接回调callback，原因是当前组件布局完成后可能还有其它组件未完成布局
    // 如果callback中又触发了UI更新（比如调用了 setState）则会报错。因此，我们
    // 在 frame 结束的时候再去触发回调。
    SchedulerBinding.instance!
        .addPostFrameCallback((timeStamp) => callback(this));
  }

  /// 组件在屏幕坐标中的起始点坐标（偏移）
  Offset get offset => localToGlobal(Offset.zero);

  /// 组件在屏幕上占有的矩形空间区域
  Rect get rect => offset & size;
}
