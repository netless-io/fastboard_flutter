import 'package:flutter/widgets.dart';

import '../types/types.dart';
import 'fast_icons.dart';
import 'fast_tool_box.dart';

class FastUiSettings {
  static Map<FastAppliance, List<Widget>> applianceIcons = {
    FastAppliance.clicker: [FastIcons.click, FastIcons.clickFill],
    FastAppliance.arrow: [FastIcons.arrow, FastIcons.arrowBold],
    FastAppliance.straight: [FastIcons.straight, FastIcons.straightBold],
    FastAppliance.selector: [FastIcons.selector, FastIcons.selectorFill],
    FastAppliance.text: [FastIcons.text, FastIcons.textFill],
    FastAppliance.rectangle: [FastIcons.rectangle, FastIcons.rectangleBold],
    FastAppliance.ellipse: [FastIcons.circle, FastIcons.circleBold],
    FastAppliance.eraser: [FastIcons.eraser, FastIcons.eraserFill],
    FastAppliance.pencil: [FastIcons.pencil, FastIcons.pencilFill],
    FastAppliance.pentagram: [FastIcons.star, FastIcons.starBold],
    FastAppliance.rhombus: [FastIcons.rhombus, FastIcons.rhombusBold],
    FastAppliance.triangle: [FastIcons.triangle, FastIcons.triangleBold],
    FastAppliance.balloon: [FastIcons.balloon, FastIcons.balloonBold],
    FastAppliance.clear: [FastIcons.clear, FastIcons.clear],
  };

  static List<Widget> iconOf(FastAppliance appliance) {
    return applianceIcons[appliance]!;
  }

  static List<Color> strokeColors = [
    Color(0xFFEC3455),
    Color(0xFFF5AD46),
    Color(0xFF68AB5D),
    Color(0xFF32C5FF),
    Color(0xFF005BF6),
    Color(0xFF6236FF),
    Color(0xFF9E51B6),
    Color(0xFF6D7278),
  ];

  static List<ToolboxItem> expandItems = [
    ToolboxItem(appliances: [FastAppliance.clicker]),
    ToolboxItem(appliances: [FastAppliance.selector]),
    ToolboxItem(
      appliances: [FastAppliance.pencil],
      subItems: [
        SubToolboxItem.noValue(SubToolboxKey.strokeWidth),
        SubToolboxItem.noValue(SubToolboxKey.strokeColor),
      ],
    ),
    ToolboxItem(
      appliances: [FastAppliance.text],
      subItems: [
        SubToolboxItem.noValue(SubToolboxKey.strokeWidth),
        SubToolboxItem.noValue(SubToolboxKey.strokeColor),
      ],
    ),
    ToolboxItem(appliances: [FastAppliance.eraser]),
    ToolboxItem(
      appliances: [
        FastAppliance.rectangle,
        FastAppliance.ellipse,
        FastAppliance.straight,
        FastAppliance.arrow,
        FastAppliance.pentagram,
        FastAppliance.rhombus,
        FastAppliance.triangle,
        FastAppliance.balloon,
      ],
      subItems: [
        SubToolboxItem.noValue(SubToolboxKey.strokeWidth),
        SubToolboxItem.noValue(SubToolboxKey.strokeColor),
      ],
    ),
    ToolboxItem(appliances: [FastAppliance.clear]),
  ];
}
