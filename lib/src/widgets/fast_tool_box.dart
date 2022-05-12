import 'package:flutter/material.dart';

import '../controller.dart';
import '../types/types.dart';
import 'widgets.dart';

class FastToolBoxExpand extends FastRoomControllerWidget {
  const FastToolBoxExpand(FastRoomController controller,
      {Key? key, bool? expand})
      : super(controller, key: key);

  @override
  State<StatefulWidget> createState() {
    return FastToolBoxExpandState();
  }
}

class FastToolBoxExpandState
    extends FastRoomControllerState<FastToolBoxExpand> {
  var items = FastUiSettings.expandItems;

  Rect? _rect;
  num? _strokeWidth;
  Color? _strokeColor;

  FastAppliance selectedAppliance = FastAppliance.unknown;
  int selectedIndex = -1;
  int overlayKey = 0;
  bool showSubTools = false;

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
        selected: selectedIndex == i,
        expandable: items[i].expandable,
        icons: FastIcon(
          FastUiSettings.iconOf(items[i].displayAppliance),
          selected: selectedIndex == i,
        ),
        onTap: () {
          handleTabIndex(i);
        },
      ));
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: AfterLayout(
            callback: (renderAfterLayout) {
              _rect = renderAfterLayout.localToGlobal(
                    Offset.zero,
                    ancestor: context.findRenderObject(),
                  ) &
                  renderAfterLayout.size;
              setState(() {});
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
            child: buildSubToolbox(),
            top: _rect!.top,
            left: _rect!.right + FastGap.gap_3,
          ),
        if (selectedAppliance == FastAppliance.selector)
          Positioned(
            child: buildDeleteButton(),
            top: _rect!.top - FastGap.gap_3 - FastGap.gap_8,
            left: _rect!.left,
          ),
      ],
    );
  }

  Widget buildSubToolbox() {
    var themeData = FastTheme.of(context)!.data;

    List<Widget> children = [];
    var appliances = items[selectedIndex].appliances;
    if (appliances.length > 1) {
      children.add(buildSubToolAppliance(appliances));
    }
    for (var element in items[selectedIndex].subItems) {
      if (children.isNotEmpty) {
        children.add(Padding(
          padding: EdgeInsets.all(FastGap.gap_1),
          child: Container(
            height: FastGap.gapMin,
            color: themeData.dividerColor,
          ),
        ));
      }
      switch (element.key) {
        case SubToolboxKey.strokeWidth:
          children.add(buildSubToolStroke());
          break;
        case SubToolboxKey.strokeColor:
          children.add(buildSubToolColor());
          break;
        case SubToolboxKey.strokeTextColor:
          break;
      }
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
    var themeData = FastTheme.of(context)!.data;

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
    var themeData = FastTheme.of(context)!.data;

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
            // icons: FastUiSettings.iconOf(appliances[index]),
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
    if (selectedIndex != -1) {
      items[selectedIndex].updateAppliance(appliance);
    }
    widget.controller.setAppliance(appliance);
  }

  void handleTabIndex(int index) {
    if (index == selectedIndex) {
      if (!items[index].expandable) return;
      if (isSubAppliancesShown()) {
        hideSubAppliances();
      } else {
        showSubAppliances();
      }
    } else {
      hideSubAppliances();
      setState(() {
        if (items[index].displayAppliance == FastAppliance.clear) {
          widget.controller.cleanScene();
          return;
        }

        selectedIndex = index;
        widget.controller.setAppliance(items[index].displayAppliance);
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

    selectedIndex = -1;
    for (var i = 0; i < items.length; ++i) {
      if (items[i].appliances.contains(selectedAppliance)) {
        items[i].updateAppliance(selectedAppliance);
        selectedIndex = i;
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
}

class ToolboxItem {
  List<FastAppliance> appliances;
  int displayIndex;
  List<SubToolboxItem> subItems;

  bool get expandable => subItems.isNotEmpty;

  FastAppliance get displayAppliance => appliances[displayIndex];

  void updateAppliance(FastAppliance fastAppliance) {
    for (int i = 0; i < appliances.length; i++) {
      if (appliances[i] == fastAppliance) {
        displayIndex = i;
        break;
      }
    }
  }

  ToolboxItem({
    required this.appliances,
    this.displayIndex = 0,
    this.subItems = const <SubToolboxItem>[],
  });
}

enum SubToolboxKey {
  strokeWidth,
  strokeColor,
  strokeTextColor,
}

class SubToolboxItem {
  SubToolboxItem(this.key, this.value);

  SubToolboxItem.noValue(SubToolboxKey key) : this(key, null);

  final SubToolboxKey key;
  final Object? value;
}
