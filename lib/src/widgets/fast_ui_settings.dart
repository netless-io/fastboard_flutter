import 'package:fastboard_flutter/src/widgets/fast_icons.dart';
import 'package:flutter/widgets.dart';

import '../types/types.dart';

class FastUiSettings {
  static Map<FastAppliance, FastIconData> applianceIcons = {
    FastAppliance.clicker: FastIcons.click,
    FastAppliance.arrow: FastIcons.arrow,
    FastAppliance.straight: FastIcons.straight,
    FastAppliance.selector: FastIcons.selector,
    FastAppliance.text: FastIcons.text,
    FastAppliance.rectangle: FastIcons.rectangle,
    FastAppliance.ellipse: FastIcons.circle,
    FastAppliance.eraser: FastIcons.eraser,
    FastAppliance.pencil: FastIcons.pencil,
    FastAppliance.pentagram: FastIcons.star,
    FastAppliance.rhombus: FastIcons.rhombus,
    FastAppliance.triangle: FastIcons.triangle,
    FastAppliance.balloon: FastIcons.balloon,
    FastAppliance.clear: FastIcons.clear,
  };

  static FastIconData iconOf(FastAppliance appliance) {
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

  static List<ToolboxItem> toolboxItems = [
    ToolboxItem(appliances: [FastAppliance.clicker]),
    ToolboxItem(appliances: [FastAppliance.selector]),
    ToolboxItem(appliances: [FastAppliance.pencil]),
    // not support text
    // ToolboxItem(appliances: [FastAppliance.text]),
    ToolboxItem(appliances: [FastAppliance.eraser]),
    ToolboxItem(appliances: [
      FastAppliance.rectangle,
      FastAppliance.ellipse,
      FastAppliance.straight,
      FastAppliance.arrow,
      FastAppliance.pentagram,
      FastAppliance.rhombus,
      FastAppliance.triangle,
      FastAppliance.balloon,
    ]),
    ToolboxItem(appliances: [FastAppliance.clear]),
  ];
}
