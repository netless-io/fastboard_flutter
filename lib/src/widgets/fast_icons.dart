class FastIconData {
  const FastIconData({
    required this.assets,
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

class FastIcons {
  FastIcons._();

  static const FastIconData pagePrev = FastIconData(
    assets: [
      "assets/icons/pagePrev.svg",
    ],
  );

  static const FastIconData pageNext = FastIconData(
    assets: [
      "assets/icons/pageNext.svg",
    ],
  );

  static const FastIconData pageAdd = FastIconData(
    assets: [
      "assets/icons/pageAdd.svg",
    ],
  );

  static const FastIconData undo = FastIconData(
    assets: [
      "assets/icons/undo.svg",
    ],
  );

  static const FastIconData redo = FastIconData(
    assets: [
      "assets/icons/redo.svg",
    ],
  );

  static const FastIconData zoomIn = FastIconData(
    assets: [
      "assets/icons/zoomIn.svg",
    ],
  );

  static const FastIconData zoomOut = FastIconData(
    assets: [
      "assets/icons/zoomOut.svg",
    ],
  );

  static const FastIconData zoomReset = FastIconData(
    assets: [
      "assets/icons/zoomReset.svg",
    ],
  );

  static const FastIconData click = FastIconData(
    assets: [
      "assets/icons/click.svg",
      "assets/icons/clickFill.svg",
    ],
  );

  static const FastIconData arrow = FastIconData(
    assets: [
      "assets/icons/arrow.svg",
      "assets/icons/arrowBold.svg",
    ],
  );

  static const FastIconData straight = FastIconData(
    assets: [
      "assets/icons/line.svg",
      "assets/icons/lineBold.svg",
    ],
  );

  static const FastIconData selector = FastIconData(
    assets: [
      "assets/icons/selector.svg",
      "assets/icons/selectorFill.svg",
    ],
  );

  static const FastIconData pencil = FastIconData(
    assets: [
      "assets/icons/pencil.svg",
      "assets/icons/pencilFill.svg",
    ],
  );

  static const FastIconData eraser = FastIconData(
    assets: [
      "assets/icons/eraser.svg",
      "assets/icons/eraserFill.svg",
    ],
  );

  static const FastIconData rectangle = FastIconData(
    assets: [
      "assets/icons/rectangle.svg",
      "assets/icons/rectangleBold.svg",
    ],
  );

  static const FastIconData circle = FastIconData(
    assets: [
      "assets/icons/circle.svg",
      "assets/icons/circleBold.svg",
    ],
  );

  static const FastIconData star = FastIconData(
    assets: [
      "assets/icons/star.svg",
      "assets/icons/starBold.svg",
    ],
  );

  static const FastIconData balloon = FastIconData(
    assets: [
      "assets/icons/balloon.svg",
      "assets/icons/balloonBold.svg",
    ],
  );

  static const FastIconData rhombus = FastIconData(
    assets: [
      "assets/icons/rhombus.svg",
      "assets/icons/rhombusBold.svg",
    ],
  );

  static const FastIconData triangle = FastIconData(
    assets: [
      "assets/icons/triangle.svg",
      "assets/icons/triangleBold.svg",
    ],
  );

  static const FastIconData text = FastIconData(
    assets: [
      "assets/icons/text.svg",
      "assets/icons/textFill.svg",
    ],
  );

  static const FastIconData clear = FastIconData(
    assets: [
      "assets/icons/clear.svg",
    ],
  );

  static const FastIconData expandable = FastIconData(
    assets: ["assets/icons/expandable.svg"],
  );

  static const FastIconData delete = FastIconData(
    assets: [
      "assets/icons/delete.svg",
    ],
  );
}
