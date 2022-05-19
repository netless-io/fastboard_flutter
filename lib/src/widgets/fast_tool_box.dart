import 'package:flutter/material.dart';

import '../controller.dart';
import '../types/types.dart';
import 'flutter_after_layout.dart';
import 'widgets.dart';

class FastToolBoxExpand extends FastRoomControllerWidget {
  const FastToolBoxExpand(
    FastRoomController controller, {
    Key? key,
  }) : super(controller, key: key);

  @override
  State<StatefulWidget> createState() {
    return FastToolBoxExpandState();
  }
}

class FastToolBoxExpandState
    extends FastRoomControllerState<FastToolBoxExpand> {
  var items = FastUiSettings.toolboxItems;

  num? _strokeWidth;
  Color? _strokeColor;

  FastAppliance selectedAppliance = FastAppliance.unknown;
  int lastIndex = -1;
  int overlayKey = 0;

  RenderAfterLayout? _renderAfterLayout;

  @override
  void initState() {
    super.initState();
    widget.controller.onOverlayChanged().listen((event) {
      setState(() {
        overlayKey = event.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < items.length; ++i) {
      if (i != 0) {
        children.add(const SizedBox(height: 4));
      }
      children.add(FastToolboxButton(
        selected: isSelected(items[i]),
        expandable: items[i].expandable,
        icons: FastIcon(
          FastUiSettings.iconOf(items[i].current),
          selected: isSelected(items[i]),
        ),
        onTap: () {
          handleTabIndex(i);
        },
      ));
    }

    var rect = _anchorRect;

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: AfterLayout(
            callback: (renderAfterLayout) {
              debugPrint("AfterLayout rect ${renderAfterLayout.size}");
              _renderAfterLayout = renderAfterLayout;
            },
            child: FastContainer(
              child: Column(
                children: children,
              ),
            ),
          ),
          left: FastGap.gap_3,
        ),
        if (overlayKey == OverlayChangedEvent.subAppliances)
          Positioned(
            child: buildSubToolbox(items[lastIndex]),
            top: rect.top,
            left: rect.right + FastGap.gap_3,
          ),
        if (selectedAppliance == FastAppliance.selector)
          Positioned(
            child: buildDeleteButton(),
            top: rect.top - FastGap.gap_3 - FastGap.gap_8,
            left: rect.left,
          ),
      ],
    );
  }

  Rect get _anchorRect {
    if (_renderAfterLayout != null) {
      return _renderAfterLayout!.localToGlobal(
            Offset.zero,
            ancestor: context.findRenderObject(),
          ) &
          _renderAfterLayout!.size;
    } else {
      return Rect.zero;
    }
  }

  Widget buildSubToolbox(ToolboxItem item) {
    var themeData = FastTheme.of(context);

    List<Widget> children = [];
    if (item.appliances.length > 1) {
      children.add(buildSubToolAppliance(item.appliances));
    }
    if (item.current.hasProperties) {
      if (children.isNotEmpty) {
        children.add(ToolExtensionPadding(themeData: themeData));
      }
      children.add(buildSubToolStroke());
      children.add(ToolExtensionPadding(themeData: themeData));
      children.add(buildSubToolColor());
    }
    return FastContainer(
      child: SizedBox(
        width: FastGap.subToolboxWidth,
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget buildSubToolColor() {
    var colors = FastUiSettings.strokeColors;
    var themeData = FastTheme.of(context);

    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: FastGap.gap_1,
          mainAxisSpacing: FastGap.gap_1,
        ),
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return Center(
            child: InkWell(
              onTap: () => updateStrokeColor(colors[index]),
              child: Container(
                width: FastGap.gap_6,
                height: FastGap.gap_6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  border: Border.all(
                    color: _strokeColor == colors[index]
                        ? themeData.mainColor
                        : Colors.transparent,
                    width: FastGap.gap_0_5,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(FastGap.gap_0_5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      color: colors[index],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSubToolStroke() {
    var themeData = FastTheme.of(context);

    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: themeData.mainColor,
        inactiveTrackColor: themeData.dividerColor,
        thumbColor: themeData.mainColor,
        trackHeight: FastGap.gap_1,
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: FastGap.gap_1_5,
          elevation: 2,
        ),
        overlayShape: RoundSliderOverlayShape(overlayRadius: FastGap.gap_3),
      ),
      child: Slider(
        value: _strokeWidth?.toDouble() ?? 4.0,
        onChanged: (value) {
          _strokeWidth = value;
          setState(() {});
        },
        onChangeEnd: (value) => widget.controller.setStrokeWidth(value),
        min: 1,
        max: 24,
      ),
    );
  }

  Widget buildSubToolAppliance(dynamic appliances) {
    appliances = appliances as List<FastAppliance>;
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: FastGap.gap_1,
          mainAxisSpacing: FastGap.gap_1,
        ),
        itemCount: appliances.length,
        itemBuilder: (context, index) {
          return FastToolboxButton(
            selected: appliances[index] == selectedAppliance,
            icons: FastIcon(
              FastUiSettings.iconOf(appliances[index]),
              selected: appliances[index] == selectedAppliance,
            ),
            onTap: () => {selectAppliance(appliances[index])},
          );
        },
      ),
    );
  }

  void updateStrokeColor(Color color) {
    widget.controller.setStrokeColor(color);
  }

  void selectAppliance(FastAppliance appliance) {
    for (var item in items) {
      item.update(appliance);
    }

    widget.controller.setAppliance(appliance);
  }

  void handleTabIndex(int index) {
    if (isSelected(items[index])) {
      if (!items[index].expandable) return;
      if (isSubAppliancesShown()) {
        hideSubAppliances();
      } else {
        lastIndex = index;
        showSubAppliances();
      }
    } else {
      hideSubAppliances();
      setState(() {
        if (items[index].current == FastAppliance.clear) {
          widget.controller.cleanScene();
          return;
        }

        widget.controller.setAppliance(items[index].current);
      });
    }
  }

  @override
  void calculateState() {
    var value = widget.controller.value;
    var memberState = value.roomState.memberState;
    selectedAppliance = FastAppliance.of(
      memberState?.currentApplianceName,
      memberState?.shapeType,
    );

    for (var i = 0; i < items.length; ++i) {
      if (items[i].appliances.contains(selectedAppliance)) {
        items[i].update(selectedAppliance);
      }
    }

    _strokeWidth = memberState?.strokeWidth;
    if (memberState?.strokeColor != null) {
      var cl = memberState!.strokeColor!;
      _strokeColor = Color.fromRGBO(cl[0], cl[1], cl[2], 1);
    }
  }

  bool isSubAppliancesShown() {
    return overlayKey == OverlayChangedEvent.subAppliances;
  }

  void showSubAppliances() {
    widget.controller.changeOverlay(OverlayChangedEvent.subAppliances);
  }

  void hideSubAppliances() {
    widget.controller.changeOverlay(OverlayChangedEvent.noOverlay);
  }

  Widget buildDeleteButton() {
    return FastContainer(
      child: InkWell(
        child: FastIcon(FastIcons.delete),
        onTap: _onDeleteSelected,
      ),
    );
  }

  void _onDeleteSelected() {
    widget.controller.whiteRoom?.delete();
  }

  bool isSelected(ToolboxItem item) {
    return item.current == selectedAppliance;
  }
}

class ToolExtensionPadding extends StatelessWidget {
  const ToolExtensionPadding({
    Key? key,
    required this.themeData,
  }) : super(key: key);

  final FastThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(FastGap.gap_1),
      child: Container(
        height: FastGap.gapMin,
        color: themeData.dividerColor,
      ),
    );
  }
}
