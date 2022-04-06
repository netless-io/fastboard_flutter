import 'dart:math';

import 'package:flutter/material.dart';

import '../controller.dart';
import 'fast_base_ui.dart';
import 'fast_icons.dart';

class FastZoomWidget extends FastRoomControllerWidget {
  final num minScale;
  final num maxScale;

  const FastZoomWidget(
    FastRoomController controller, {
    Key? key,
    this.minScale = 0.25,
    this.maxScale = 2,
  }) : super(controller, key: key);

  @override
  State<StatefulWidget> createState() {
    return FastZoomState();
  }
}

class FastZoomState extends FastRoomControllerState<FastZoomWidget> {
  late num zoomScale;

  @override
  void initState() {
    super.initState();
    _updateZoomScale();
  }

  @override
  Widget build(BuildContext context) {
    return FastContainer(
        child: Row(
      children: [
        InkWell(
          child: FastIcons.zoomIn,
          onTap: _onZoomIn,
        ),
        const SizedBox(width: 4),
        Text("${(zoomScale * 100).ceil()}%"),
        const SizedBox(width: 4),
        InkWell(
          child: FastIcons.zoomOut,
          onTap: _onZoomOut,
        ),
        InkWell(
          child: FastIcons.zoomReset,
          onTap: _onZoomReset,
        ),
      ],
    ));
  }

  void _onZoomIn() {
    widget.controller.zoomTo(max(zoomScale - 0.25, widget.minScale));
  }

  void _onZoomOut() {
    widget.controller.zoomTo(min(zoomScale + 0.25, widget.maxScale));
  }

  void _onZoomReset() {
    widget.controller.zoomReset();
  }

  @override
  void calculateState() {
    _updateZoomScale();
  }

  void _updateZoomScale() {
    var cameraState = widget.controller.value.roomState.cameraState;
    zoomScale = cameraState?.scale ?? 1;
  }
}
