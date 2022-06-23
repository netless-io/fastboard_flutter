import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

/// TODO when update dart to 2.17, use Enum Members replace.
class FastAppliance {
  final String appliance;
  final String? shapeType;

  const FastAppliance(this.appliance, {this.shapeType});

  /// Clicker, which can be used for clicking and selecting content on an HTML5 file.
  static const FastAppliance clicker = FastAppliance(ApplianceName.clicker);

  /// Selector
  static const FastAppliance selector = FastAppliance(ApplianceName.selector);

  /// Pencil
  static const FastAppliance pencil = FastAppliance(ApplianceName.pencil);

  /// Rectangle
  static const FastAppliance rectangle = FastAppliance(ApplianceName.rectangle);

  /// Ellipse
  static const FastAppliance ellipse = FastAppliance(ApplianceName.ellipse);

  static const FastAppliance text = FastAppliance(ApplianceName.text);

  /// Eraser
  static const FastAppliance eraser = FastAppliance(ApplianceName.eraser);

  /// Arrow
  static const FastAppliance arrow = FastAppliance(ApplianceName.arrow);

  /// Straight line.
  static const FastAppliance straight = FastAppliance(ApplianceName.straight);

  /// Pentagram
  static const FastAppliance pentagram = FastAppliance(
    ApplianceName.shape,
    shapeType: ShapeType.pentagram,
  );

  /// Rhombus
  static const FastAppliance rhombus = FastAppliance(
    ApplianceName.shape,
    shapeType: ShapeType.rhombus,
  );

  /// Triangle
  static const FastAppliance triangle = FastAppliance(
    ApplianceName.shape,
    shapeType: ShapeType.triangle,
  );

  /// Speech balloon.
  static const FastAppliance balloon = FastAppliance(
    ApplianceName.shape,
    shapeType: ShapeType.speechBalloon,
  );

  /// Clears all contents on the current whiteboard page.
  static const FastAppliance clear = FastAppliance("");

  static const FastAppliance unknown = FastAppliance("unknown");

  static Map<FastAppliance, bool> kHasProperties = <FastAppliance, bool>{
    FastAppliance.clicker: false,
    FastAppliance.selector: false,
    FastAppliance.pencil: true,
    FastAppliance.rectangle: true,
    FastAppliance.ellipse: true,
    FastAppliance.text: true,
    FastAppliance.eraser: false,
    FastAppliance.arrow: true,
    FastAppliance.straight: true,
    FastAppliance.pentagram: true,
    FastAppliance.rhombus: true,
    FastAppliance.triangle: true,
    FastAppliance.balloon: true,
    FastAppliance.clear: false,
  };

  bool get hasProperties {
    return kHasProperties[this] ?? false;
  }

  static FastAppliance of(String? appliance, String? shapeType) {
    switch (appliance) {
      case ApplianceName.clicker:
        return clicker;
      case ApplianceName.selector:
        return selector;
      case ApplianceName.pencil:
        return pencil;
      case ApplianceName.text:
        return text;
      case ApplianceName.rectangle:
        return rectangle;
      case ApplianceName.ellipse:
        return ellipse;
      case ApplianceName.eraser:
        return eraser;
      case ApplianceName.arrow:
        return arrow;
      case ApplianceName.straight:
        return straight;
      case ApplianceName.shape:
        switch (shapeType) {
          case ShapeType.pentagram:
            return pentagram;
          case ShapeType.rhombus:
            return rhombus;
          case ShapeType.triangle:
            return triangle;
          case ShapeType.speechBalloon:
            return balloon;
        }
    }
    return unknown;
  }
}
