import 'package:fastboard_flutter/fastboard_flutter.dart';
import 'package:fastboard_flutter/src/widgets/fast_base_ui.dart';
import 'package:fastboard_flutter/src/widgets/fast_resource_provider.dart';
import 'package:flutter/material.dart';

class ToolboxData {}

class FastToolBoxExpand extends FastRoomControllerWidget {
  const FastToolBoxExpand(controller, {Key? key, bool? expand})
      : super(controller, key: key);

  @override
  State<StatefulWidget> createState() {
    return FastToolBoxExpandState();
  }
}

class FastToolBoxExpandState extends State<FastToolBoxExpand> {
  int selectedIndex = -1;

  List<ToolboxItem> items = [
    ToolboxItem(appliance: FastAppliance.arrow),
    ToolboxItem(appliance: FastAppliance.selector),
    ToolboxItem(appliance: FastAppliance.pencil),
    ToolboxItem(appliance: FastAppliance.text),
    ToolboxItem(appliance: FastAppliance.eraser),
    ToolboxItem(appliance: FastAppliance.rectangle),
    ToolboxItem(appliance: FastAppliance.clear),
  ];

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
    return FastContainer(
      child: Column(
        children: children,
      ),
    );
  }

  handleTabIndex(int index) {
    if (index == selectedIndex) {
      // show subAppliances
    } else {
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
}

class ToolboxItem {
  FastAppliance appliance;
  List<FastAppliance> subAppliances;

  bool get expandable => subAppliances.isNotEmpty;

  ToolboxItem({
    required this.appliance,
    this.subAppliances = const [],
  });
}
