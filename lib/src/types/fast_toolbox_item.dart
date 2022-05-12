import 'fast_appliance.dart';

class ToolboxItem {
  ToolboxItem({
    required this.appliances,
    this.index = 0,
  });

  final List<FastAppliance> appliances;
  int index;

  bool get expandable {
    if (appliances.length == 1) {
      return appliances[0].hasProperties;
    }
    return appliances.length >= 2;
  }

  FastAppliance get current => appliances[index];

  void update(FastAppliance fastAppliance) {
    for (int i = 0; i < appliances.length; i++) {
      if (appliances[i] == fastAppliance) {
        index = i;
        break;
      }
    }
  }
}
