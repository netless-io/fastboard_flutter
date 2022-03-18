import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

import '../fastboard_flutter.dart';

class FastRoomOptions {
  WhiteOptions? _whiteOptions;

  FastRoomCreatedCallback? onFastRoomCreated;

  WhiteOptions get whiteOptions =>
      _whiteOptions ?? WhiteOptions(appIdentifier: appId);

  set whiteOptions(WhiteOptions? whiteOptions) => _whiteOptions = whiteOptions;

  RoomOptions? _roomOptions;

  RoomOptions get roomOptions =>
      _roomOptions ??
          RoomOptions(
            uuid: uuid,
            roomToken: token,
            uid: uid,
            isWritable: writable,
            region: region,
          );

  set roomOptions(RoomOptions? roomOptions) => _roomOptions = roomOptions;

  final String appId;
  final String uuid;
  final String token;
  final String uid;
  final String region;
  final bool writable;

  FastRoomOptions({
    required this.appId,
    required this.uuid,
    required this.token,
    required this.uid,
    required this.region,
    this.writable = true,
    WhiteOptions? whiteOptions,
    RoomOptions? roomOptions,
    this.onFastRoomCreated,
  }) {
    _whiteOptions = whiteOptions;
    _roomOptions = roomOptions;
  }
}

class FastReplayOptions {}

class FastStyle {
  Color? mainColor;
  bool darkMode;

  FastStyle({
    this.mainColor,
    this.darkMode = false,
  });
}

@immutable
class FastRedoUndoCount {
  final int redo;
  final int undo;

  const FastRedoUndoCount({
    this.redo = 0,
    this.undo = 0,
  });

  FastRedoUndoCount copyWith({
    int? redoParam,
    int? undoParam,
  }) {
    return FastRedoUndoCount(
      redo: redoParam ?? redo,
      undo: undoParam ?? undo,
    );
  }
}

enum FastRegion {
  /// `cn_hz`：中国杭州。
  /// <p>
  /// 该数据中心为其他数据中心服务区未覆盖的地区提供服务。
  cn_hz,

  /// `us_sv`：美国硅谷。
  /// <p>
  /// 该数据中心为北美洲、南美洲地区提供服务。
  us_sv,

  /// `sg`：新加坡。
  /// <p>
  /// 该数据中心为新加坡、东亚、东南亚地区提供服务。
  sg,

  /// `in_mum`：印度孟买。
  /// <p>
  /// 该数据中心为印度地区提供服务。
  in_mum,

  /// `gb_lon`：英国伦敦。
  /// <p>
  /// 该数据中心为欧洲地区提供服务。
  gb_lon,
}

class FastAppliance {
  final String appliance;
  final String? shapeType;

  const FastAppliance(this.appliance, {this.shapeType});

  static const FastAppliance clicker = FastAppliance(ApplianceName.clicker);
  static const FastAppliance selector = FastAppliance(ApplianceName.selector);
  static const FastAppliance pencil = FastAppliance(ApplianceName.pencil);
  static const FastAppliance rectangle = FastAppliance(ApplianceName.rectangle);
  static const FastAppliance ellipse = FastAppliance(ApplianceName.ellipse);
  static const FastAppliance text = FastAppliance(ApplianceName.text);
  static const FastAppliance eraser = FastAppliance(ApplianceName.eraser);
  static const FastAppliance arrow = FastAppliance(ApplianceName.arrow);
  static const FastAppliance straight = FastAppliance(ApplianceName.straight);

  static const FastAppliance pentagram =
  FastAppliance(ApplianceName.shape, shapeType: ShapeType.pentagram);
  static const FastAppliance rhombus =
  FastAppliance(ApplianceName.shape, shapeType: ShapeType.rhombus);
  static const FastAppliance triangle =
  FastAppliance(ApplianceName.shape, shapeType: ShapeType.triangle);
  static const FastAppliance speechBalloon =
  FastAppliance(ApplianceName.shape, shapeType: ShapeType.speechBalloon);

  static const FastAppliance clear = FastAppliance("");
}

class ToolboxData {}
