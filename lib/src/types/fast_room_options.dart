import 'dart:ui';

import 'package:fastboard_flutter/fastboard_flutter.dart';

/// [FastRoomOptions] is configuration options for a whiteboard room.
class FastRoomOptions {
  /// The App Identifier of your Interactive Whiteboard project issued by Agora
  final String appId;

  /// The room uuid, that is, the unique identifier of a room.
  final String uuid;

  /// The room token for user authentication
  final String token;

  /// The unique identifier of a user in string format
  final String uid;

  /// The data center, which must be the same as the data center you chose when creating the whiteboard room
  final FastRegion fastRegion;

  /// Whether the user joins the whiteboard room in interactive mode:
  /// true: Join the whiteboard room in interactive mode, that is, with read and write permissions.
  /// false: Join the whiteboard room in subscription mode, that is, with read-only permission.
  final bool writable;

  /// fastboard has a strong dependency on multi-window. It's support some apis like insertDoc, insertVideo etc.
  final bool useMultiViews;

  /// Local display of multi-window content height to width ratio, default is 9:16
  final double? containerSizeRatio;

  /// CSS transmit to multi-window
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
    this.useMultiViews = true,
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
      useMultiViews: useMultiViews,
      backgroundColor: backgroundColor,
    );
  }

  RoomOptions genRoomOptions({
    double? ratioWhenNull,
    WindowPrefersColorScheme? prefersColorScheme,
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
        prefersColorScheme: prefersColorScheme,
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
