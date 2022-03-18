import 'package:flutter/cupertino.dart';

class FastContainer extends StatelessWidget {
  final Widget? child;

  const FastContainer({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: child,
      decoration: const BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(width: 1.0, color: Color(0xFFE5E8F0)),
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
    );
  }
}
