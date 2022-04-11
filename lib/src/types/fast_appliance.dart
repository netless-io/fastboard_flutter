import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

class FastAppliance {
  final String appliance;
  final String? shapeType;

  const FastAppliance(this.appliance, {this.shapeType});

  static const FastAppliance clicker = FastAppliance(ApplianceName.clicker);
  static const FastAppliance selector = FastAppliance(ApplianceName.selector);
  static const FastAppliance pencil = FastAppliance(ApplianceName.pencil);
  static const FastAppliance rectangle = FastAppliance(ApplianceName.rectangle);
  static const FastAppliance ellipse = FastAppliance(ApplianceName.ellipse);
  static const FastAppliance text = FastAppliance(ApplianceName.text);
  static const FastAppliance eraser = FastAppliance(ApplianceName.eraser);
  static const FastAppliance arrow = FastAppliance(ApplianceName.arrow);
  static const FastAppliance straight = FastAppliance(ApplianceName.straight);

  static const FastAppliance pentagram =
      FastAppliance(ApplianceName.shape, shapeType: ShapeType.pentagram);
  static const FastAppliance rhombus =
      FastAppliance(ApplianceName.shape, shapeType: ShapeType.rhombus);
  static const FastAppliance triangle =
      FastAppliance(ApplianceName.shape, shapeType: ShapeType.triangle);
  static const FastAppliance speechBalloon =
      FastAppliance(ApplianceName.shape, shapeType: ShapeType.speechBalloon);

  static const FastAppliance clear = FastAppliance("");

  static FastAppliance of(String? appliance, String? shapeType) {
    switch (appliance) {
      case ApplianceName.clicker:
        return clicker;
      case ApplianceName.selector:
        return selector;
      case ApplianceName.pencil:
        return pencil;
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
            return speechBalloon;
        }
    }
    return clicker;
  }
}
