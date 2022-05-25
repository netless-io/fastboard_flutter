import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controller.dart';
import 'widgets.dart';

abstract class FastRoomControllerWidget extends StatefulWidget {
  final FastRoomController controller;

  const FastRoomControllerWidget(
    this.controller, {
    Key? key,
  }) : super(key: key);
}

abstract class FastRoomControllerState<T extends FastRoomControllerWidget>
    extends State<T> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_handleChange);
      widget.controller.addListener(_handleChange);
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    widget.controller.removeListener(_handleChange);
  }

  void _handleChange() {
    calculateState();
    setState(() {});
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
    var themeData = FastTheme.of(context);

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

  final Widget? icons;

  final GestureTapCallback? onTap;

  const FastToolboxButton({
    Key? key,
    this.selected = false,
    this.expandable = false,
    this.icons,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = FastTheme.of(context);

    var color = selected ? themeData.borderColor : null;

    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              FastGap.gap_1,
            )),
        child: GestureDetector(
          child: Stack(
            children: [
              if (expandable) FastIcon(FastIcons.expandable),
              if (icons != null) icons!,
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
  final FastIconData icon;

  const FastIcon(
    this.icon, {
    Key? key,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = FastTheme.of(context);

    return SvgPicture.asset(
      icon.assetBySelected(selected),
      package: icon.package,
      width: FastGap.gap_6,
      height: FastGap.gap_6,
      color: themeData.iconColor,
    );
  }
}
