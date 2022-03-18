import 'package:fastboard_flutter/fastboard_flutter.dart';
import 'package:fastboard_flutter/src/ui/fast_icons.dart';
import 'package:flutter/cupertino.dart';

class FastResourceProvider {
  static Map<FastAppliance, List<Widget>> applianceIcons = {
    FastAppliance.arrow: [FastIcons.arrow, FastIcons.arrowBold],
    FastAppliance.selector: [FastIcons.selector, FastIcons.selectorFill],
    FastAppliance.text: [FastIcons.text, FastIcons.textFill],
    FastAppliance.rectangle: [FastIcons.rectangle, FastIcons.rectangleBold],
    FastAppliance.eraser: [FastIcons.eraser, FastIcons.eraserFill],
    FastAppliance.pencil: [FastIcons.pencil, FastIcons.pencilFill],
    FastAppliance.clear: [FastIcons.clear, FastIcons.clear],
  };

  static List<Widget> iconOf(FastAppliance appliance) {
    return applianceIcons[appliance]!;
  }
}
