import 'package:fastboard_flutter/src/widgets/fast_icons.dart';
import 'package:flutter/material.dart';

import '../controller.dart';
import '../types/types.dart';
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
  List<ToolboxItem> items = [
    ToolboxItem(appliances: [FastAppliance.clicker]),
    ToolboxItem(appliances: [FastAppliance.selector]),
    ToolboxItem(
      appliances: [FastAppliance.pencil],
      subItems: [
        SubToolboxItem.noValue(
          SubToolboxKey.strokeWidth,
        ),
        SubToolboxItem.noValue(
          SubToolboxKey.strokeColor,
        ),
      ],
    ),
    ToolboxItem(appliances: [FastAppliance.text]),
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
        SubToolboxItem.noValue(
          SubToolboxKey.strokeWidth,
        ),
        SubToolboxItem.noValue(
          SubToolboxKey.strokeColor,
        ),
      ],
    ),
    ToolboxItem(appliances: [FastAppliance.clear]),
  ];

  Rect? _rect;
  num? _strokeWidth;
  Color? _strokeColor;

  int selectedIndex = -1;
  int overlayKey = 0;
  bool showSubTools = false;
  bool showDelete = false;

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
        icons: FastResourceProvider.iconOf(items[i].displayAppliance),
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
    var appliances = items[selectedIndex].appliances;
    if (appliances.length > 1) {
      children.add(buildSubToolAppliance(appliances));
    }
    for (var element in items[selectedIndex].subItems) {
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
        case SubToolboxKey.strokeTextColor:
          // TODO: Handle this case.
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
    var colors = FastResourceProvider.colors;
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
              padding: EdgeInsets.all(2),
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
              ),
              child: Container(
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
        min: 1,
        max: 24,
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
    var fastAppliance = FastAppliance.of(
      memberState?.currentApplianceName,
      memberState?.shapeType,
    );

    selectedIndex = -1;
    for (var i = 0; i < items.length; ++i) {
      if (items[i].appliances.contains(fastAppliance)) {
        items[i].updateAppliance(fastAppliance);
        selectedIndex = i;
      }
    }
    showDelete = fastAppliance == FastAppliance.selector;

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
