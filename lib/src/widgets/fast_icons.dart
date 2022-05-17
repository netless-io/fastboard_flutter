/// icons data, [0] for normal state, [1] for selected state.
class FastIconData {
  const FastIconData(
    this.assets, {
    this.package = "fastboard_flutter",
  });

  final List<String> assets;

  final String? package;

  String get assetNormal => assets[0];

  String assetBySelected(bool selected) {
    return selected
        ? assets.length > 1
            ? assets[1]
            : assets[0]
        : assets[0];
  }
}

/// [FastIconData] constants which using by fastboard
class FastIcons {
  FastIcons._();

  static const FastIconData pagePrev = FastIconData(
    [
      "assets/icons/pagePrev.svg",
    ],
  );

  static const FastIconData pageNext = FastIconData(
    [
      "assets/icons/pageNext.svg",
    ],
  );

  static const FastIconData pageAdd = FastIconData(
    [
      "assets/icons/pageAdd.svg",
    ],
  );

  static const FastIconData undo = FastIconData(
    [
      "assets/icons/undo.svg",
    ],
  );

  static const FastIconData redo = FastIconData(
    [
      "assets/icons/redo.svg",
    ],
  );

  static const FastIconData zoomIn = FastIconData(
    [
      "assets/icons/zoomIn.svg",
    ],
  );

  static const FastIconData zoomOut = FastIconData(
    [
      "assets/icons/zoomOut.svg",
    ],
  );

  static const FastIconData zoomReset = FastIconData(
    [
      "assets/icons/zoomReset.svg",
    ],
  );

  static const FastIconData click = FastIconData(
    [
      "assets/icons/click.svg",
      "assets/icons/clickFill.svg",
    ],
  );

  static const FastIconData arrow = FastIconData(
    [
      "assets/icons/arrow.svg",
      "assets/icons/arrowBold.svg",
    ],
  );

  static const FastIconData straight = FastIconData(
    [
      "assets/icons/line.svg",
      "assets/icons/lineBold.svg",
    ],
  );

  static const FastIconData selector = FastIconData(
    [
      "assets/icons/selector.svg",
      "assets/icons/selectorFill.svg",
    ],
  );

  static const FastIconData pencil = FastIconData(
    [
      "assets/icons/pencil.svg",
      "assets/icons/pencilFill.svg",
    ],
  );

  static const FastIconData eraser = FastIconData(
    [
      "assets/icons/eraser.svg",
      "assets/icons/eraserFill.svg",
    ],
  );

  static const FastIconData rectangle = FastIconData(
    [
      "assets/icons/rectangle.svg",
      "assets/icons/rectangleBold.svg",
    ],
  );

  static const FastIconData circle = FastIconData(
    [
      "assets/icons/circle.svg",
      "assets/icons/circleBold.svg",
    ],
  );

  static const FastIconData star = FastIconData(
    [
      "assets/icons/star.svg",
      "assets/icons/starBold.svg",
    ],
  );

  static const FastIconData balloon = FastIconData(
    [
      "assets/icons/balloon.svg",
      "assets/icons/balloonBold.svg",
    ],
  );

  static const FastIconData rhombus = FastIconData(
    [
      "assets/icons/rhombus.svg",
      "assets/icons/rhombusBold.svg",
    ],
  );

  static const FastIconData triangle = FastIconData(
    [
      "assets/icons/triangle.svg",
      "assets/icons/triangleBold.svg",
    ],
  );

  static const FastIconData text = FastIconData(
    [
      "assets/icons/text.svg",
      "assets/icons/textFill.svg",
    ],
  );

  static const FastIconData clear = FastIconData(
    [
      "assets/icons/clear.svg",
    ],
  );

  static const FastIconData expandable = FastIconData(
    [
      "assets/icons/expandable.svg",
    ],
  );

  static const FastIconData delete = FastIconData(
    [
      "assets/icons/delete.svg",
    ],
  );
}
