import 'dart:convert';
import 'dart:math';

import 'package:fastboard_flutter/src/ui/fast_base_ui.dart';
import 'package:flutter/material.dart';

import 'fast_icons.dart';

/// display page indicate
class FastPageIndicator extends FastRoomControllerWidget {
  FastPageIndicator(controller, {Key? key}) : super(controller, key: key);

  @override
  State<StatefulWidget> createState() {
    return FastPageIndicatorState();
  }
}

class FastPageIndicatorState extends State<FastPageIndicator> {
  String indicate = "1/23";

  FastPageIndicatorState() {
    _listener = () {
      print(jsonEncode(widget.controller.value));
    };
  }

  late VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
  }

  @override
  void didUpdateWidget(FastPageIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.controller.removeListener(_listener);
    widget.controller.addListener(_listener);
  }

  @override
  void deactivate() {
    super.deactivate();
    widget.controller.removeListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return FastContainer(
      child: Row(
        children: [
          InkWell(
            child: FastIcons.pagePrev,
            onTap: () => {},
          ),
          const SizedBox(width: 4),
          Text(indicate),
          const SizedBox(width: 4),
          InkWell(
            child: FastIcons.pageNext,
            onTap: () => {},
          ),
          const SizedBox(width: 4),
          InkWell(
            child: FastIcons.pageAdd,
            onTap: () => {
              widget.controller.cleanScene()
            },
          ),
        ],
      ),
    );
  }
}
