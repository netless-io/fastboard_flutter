import 'package:fastboard_flutter/fastboard_flutter.dart';
import 'package:fastboard_flutter/src/ui/fast_icons.dart';
import 'package:flutter/material.dart';

abstract class FastRoomControllerWidget extends StatefulWidget {
  final FastRoomController controller;

  const FastRoomControllerWidget(this.controller, {Key? key})
      : super(key: key);
}

class FastContainer extends StatelessWidget {
  final Widget? child;

  const FastContainer({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: child,
      decoration: const BoxDecoration(
          // color: Colors.white,
          border: Border.fromBorderSide(
            BorderSide(width: 1.0, color: Color(0xFFE5E8F0)),
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
    );
  }
}

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
    var color = selected ? const Color(0xFFE8F2FF) : null;
    var svgIcon = selected ? icons[1] : icons[0];

    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(4.0))),
      child: InkWell(
        child: Stack(
          children: [
            if (expandable) FastIcons.expandable,
            svgIcon,
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
