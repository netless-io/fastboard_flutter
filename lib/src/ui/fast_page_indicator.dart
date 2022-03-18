import 'package:fastboard_flutter/src/ui/fast_base_ui.dart';
import 'package:flutter/material.dart';

import 'fast_icons.dart';

/// display page indicate
class FastPageIndicator extends StatefulWidget {
  const FastPageIndicator({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FastPageIndicatorState();
  }
}

class FastPageIndicatorState extends State<FastPageIndicator> {
  String indicate = "1/23";

  @override
  Widget build(BuildContext context) {
    return FastContainer(
      child: Row(
        children: [
          InkWell(
            child: FastIcons.pagePrev,
            onTap: () => {},
          ),
          const SizedBox(width: 4),
          Text(indicate),
          const SizedBox(width: 4),
          InkWell(
            child: FastIcons.pageNext,
            onTap: () => {},
          ),
          const SizedBox(width: 4),
          InkWell(
            child: FastIcons.pageAdd,
            onTap: () => {},
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
