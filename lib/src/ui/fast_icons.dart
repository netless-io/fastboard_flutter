import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FastIcons {
  FastIcons._();

  static Widget pagePrev = SvgPicture.asset(
    "icons/fast_ic_tool_scene_prev.svg",
    package: "fastboard_flutter",
    width: 24.0,
    height: 24.0,
  );

  static Widget pageNext = SvgPicture.asset(
    "icons/fast_ic_tool_scene_next.svg",
    package: "fastboard_flutter",
    width: 24.0,
    height: 24.0,
  );

  static Widget pageAdd = SvgPicture.asset(
    "icons/fast_ic_tool_scene_add.svg",
    package: "fastboard_flutter",
    width: 24.0,
    height: 24.0,
  );
}
