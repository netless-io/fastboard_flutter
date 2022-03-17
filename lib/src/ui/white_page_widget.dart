import 'package:flutter/material.dart';

import 'fast_icons.dart';

class WhitePageWidget extends StatefulWidget {
  const WhitePageWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WhitePageWidgetState();
  }
}

class WhitePageWidgetState extends State<WhitePageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          InkWell(
            child: FastIcons.pagePrev,
            onTap: () => {},
          ),
          const SizedBox(width: 4),
          const Text("1/23"),
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
      decoration: const BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(width: 1.0, color: Color(0xFFE5E8F0)),
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
    );
  }
}
