import 'dart:ui';

import 'package:fastboard_flutter/fastboard_flutter.dart';

class FastRoomOptions {
  final String appId;
  final String uuid;
  final String token;
  final String uid;
  final FastRegion fastRegion;
  final bool writable;

  /// Local display of multi-window content height to width ratio, default is 9:16
  final double? containerSizeRatio;

  /// CSS transmit to window
  /// e.g.
  /// {
  ///  "top": "40",
  ///  "left": "40",
  ///  "right": "40",
  ///  "bottom": "40",
  ///  "position": "fixed",
  /// }
  final Map<String, String>? collectorStyles;

  FastRoomOptions({
    required this.appId,
    required this.uuid,
    required this.token,
    required this.uid,
    required this.fastRegion,
    this.writable = true,
    this.containerSizeRatio,
    this.collectorStyles,
  });
}

extension FastRoomOptionsExtension on FastRoomOptions {
  WhiteOptions genWhiteOptions({
    Color? backgroundColor,
  }) {
    return WhiteOptions(
      appIdentifier: appId,
      useMultiViews: true,
      backgroundColor: backgroundColor,
    );
  }

  RoomOptions genRoomOptions({
    double? ratioWhenNull,
  }) {
    return RoomOptions(
      uuid: uuid,
      roomToken: token,
      uid: uid,
      isWritable: writable,
      region: fastRegion.toRegion(),
      disableNewPencil: false,
      windowParams: WindowParams(
        containerSizeRatio: containerSizeRatio ?? ratioWhenNull ?? 9 / 16,
        chessboard: false,
        collectorStyles: collectorStyles ??
            {
              "right": "40",
              "bottom": "40",
              "position": "fixed",
            },
      ),
    );
  }
}
