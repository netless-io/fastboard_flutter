import 'package:fastboard_flutter/src/widgets/fast_icons.dart';
import 'package:flutter/material.dart';

import '../../fastboard_flutter.dart';
import 'fast_base_ui.dart';
import 'fast_resource_provider.dart';

class ToolboxData {}

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
  int selectedIndex = -1;
  int overlayKey = 0;

  bool showSubTools = false;

  List<ToolboxItem> items = [
    ToolboxItem(
      appliance: FastAppliance.arrow,
      subAppliances: [
        SubToolboxItem(
          SubToolboxKey.appliance,
          [FastAppliance.arrow, FastAppliance.straight],
        ),
        SubToolboxItem.noValue(
          SubToolboxKey.strokeColor,
        ),
        SubToolboxItem.noValue(
          SubToolboxKey.strokeWidth,
        )
      ],
    ),
    ToolboxItem(appliance: FastAppliance.selector),
    ToolboxItem(
      appliance: FastAppliance.pencil,
      subAppliances: [
        SubToolboxItem.noValue(
          SubToolboxKey.strokeWidth,
        ),
        SubToolboxItem.noValue(
          SubToolboxKey.strokeColor,
        ),
      ],
    ),
    ToolboxItem(appliance: FastAppliance.text),
    ToolboxItem(appliance: FastAppliance.eraser),
    ToolboxItem(appliance: FastAppliance.rectangle),
    ToolboxItem(appliance: FastAppliance.clear),
  ];

  Rect? _rect;
  num? _strokeWidth;
  Color? _strokeColor;
  bool showDelete = false;

  List<Color> colors = [
    Color(0xFFEC3455),
    Color(0xFFF5AD46),
    Color(0xFF68AB5D),
    Color(0xFF32C5FF),
    Color(0xFF005BF6),
    Color(0xFF6236FF),
    Color(0xFF9E51B6),
    Color(0xFF6D7278),
  ];

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
        icons: FastResourceProvider.iconOf(items[i].appliance),
        onTap: () => {handleTabIndex(i)},
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
          left: 12,
        ),
        if (overlayKey == OverlayChangedEvent.subAppliances)
          Positioned(
            child: buildSubToolbox(),
            top: _rect!.top,
            left: _rect!.right + 12,
          ),
        if (showDelete)
          Positioned(
            child: buildDeleteButton(),
            top: _rect!.top - 12 - 32,
            left: _rect!.left,
          ),
      ],
    );
  }

  Widget buildSubToolbox() {
    List<Widget> children = [];
    for (var element in items[selectedIndex].subAppliances) {
      if (children.isNotEmpty) {
        children.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Container(
            height: 0.5,
            color: Colors.grey,
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
        case SubToolboxKey.appliance:
          children.add(buildSubToolAppliance(element.value));
          break;
      }
    }
    return FastContainer(
      child: SizedBox(
        width: 128,
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Container buildSubToolColor() {
    return Container(
      width: 120,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => updateStrokeColor(colors[index]),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: _strokeColor == colors[index]
                    ? Border.all(
                        color: Colors.blue,
                        width: 2,
                      )
                    : null,
                color: colors[index],
              ),
            ),
          );
        },
      ),
    );
  }

  SliderTheme buildSubToolStroke() {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 4,
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: 6,
          elevation: 2,
        ),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 10.0),
      ),
      child: Slider(
        value: _strokeWidth?.toDouble() ?? 4.0,
        onChanged: (value) {
          _strokeWidth = value;
          setState(() {});
        },
        onChangeEnd: (value) => widget.controller.setStrokeWidth(value),
        min: 4,
        max: 12,
      ),
    );
  }

  Container buildSubToolAppliance(dynamic appliances) {
    appliances = appliances as List<FastAppliance>;
    return Container(
      width: 120,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: appliances.length,
        itemBuilder: (context, index) {
          return FastToolboxButton(
            icons: FastResourceProvider.iconOf(appliances[index]),
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
      items[selectedIndex].appliance = appliance;
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
        if (items[index].appliance == FastAppliance.clear) {
          widget.controller.cleanScene();
          return;
        }

        selectedIndex = index;
        widget.controller.setAppliance(items[index].appliance);
      });
    }
  }

  @override
  void calculateState() {
    var value = widget.controller.value;
    var memberState = value.roomState.memberState;

    selectedIndex = -1;
    for (var i = 0; i < items.length; ++i) {
      var fastAppliance = items[i].appliance;
      if (memberState?.currentApplianceName == fastAppliance.appliance &&
          memberState?.shapeType == fastAppliance.shapeType) {
        selectedIndex = i;
      }
    }

    _strokeWidth = memberState?.strokeWidth;
    if (memberState?.strokeColor != null) {
      var cl = memberState!.strokeColor!;
      _strokeColor = Color.fromRGBO(cl[0], cl[1], cl[2], 1);
    }

    var fastAppliance = FastAppliance.of(
      memberState?.currentApplianceName,
      memberState?.shapeType,
    );
    showDelete = fastAppliance == FastAppliance.selector;
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
        child: FastIcons.delete,
        onTap: _onDeleteSelected,
      ),
    );
  }

  void _onDeleteSelected() {
    widget.controller.whiteRoom?.delete();
  }
}

class ToolboxItem {
  FastAppliance appliance;
  List<SubToolboxItem> subAppliances;

  bool get expandable => subAppliances.isNotEmpty;

  ToolboxItem({
    required this.appliance,
    this.subAppliances = const <SubToolboxItem>[],
  });
}

enum SubToolboxKey {
  strokeWidth,
  strokeColor,
  appliance,
}

class SubToolboxItem {
  SubToolboxItem(this.key, this.value);

  SubToolboxItem.noValue(SubToolboxKey key) : this(key, null);

  final SubToolboxKey key;
  final Object? value;
}
