import 'package:fastboard_flutter/fastboard_flutter.dart';

class FastRoomOptions {
  WhiteOptions? _whiteOptions;

  WhiteOptions get whiteOptions =>
      _whiteOptions ??
      WhiteOptions(
        appIdentifier: appId,
        useMultiViews: true,
      );

  set whiteOptions(WhiteOptions? whiteOptions) => _whiteOptions = whiteOptions;

  RoomOptions? _roomOptions;

  RoomOptions get roomOptions =>
      _roomOptions ??
      RoomOptions(
        uuid: uuid,
        roomToken: token,
        uid: uid,
        isWritable: writable,
        region: fastRegion.toRegion(),
        disableNewPencil: false,
        windowParams: WindowParams(
          containerSizeRatio: 9 / 16,
          chessboard: false,
        ),
      );

  set roomOptions(RoomOptions? roomOptions) => _roomOptions = roomOptions;

  final String appId;
  final String uuid;
  final String token;
  final String uid;
  final FastRegion fastRegion;
  final bool writable;

  FastRoomOptions({
    required this.appId,
    required this.uuid,
    required this.token,
    required this.uid,
    required this.fastRegion,
    this.writable = true,
    WhiteOptions? whiteOptions,
    RoomOptions? roomOptions,
  }) {
    _whiteOptions = whiteOptions;
    _roomOptions = roomOptions;
  }
}
