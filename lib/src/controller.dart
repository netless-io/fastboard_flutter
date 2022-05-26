import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

import 'types/types.dart';
import 'utils/converter.dart';

class FastRoomController extends ValueNotifier<FastRoomValue> {
  FastRoomController(this.fastRoomOptions)
      : super(FastRoomValue.uninitialized(fastRoomOptions.writable));

  WhiteSdk? whiteSdk;
  WhiteRoom? whiteRoom;
  FastRoomOptions fastRoomOptions;

  num zoomScaleDefault = 1;

  final StreamController<FastRoomEvent> _fastEventStreamController =
      StreamController<FastRoomEvent>.broadcast();

  Stream<OverlayChangedEvent> onOverlayChanged() {
    return _fastEventStreamController.stream.whereType<OverlayChangedEvent>();
  }

  Stream<FastErrorEvent> onError() {
    return _fastEventStreamController.stream.whereType<FastErrorEvent>();
  }

  void changeOverlay(int key) {
    _fastEventStreamController.add(OverlayChangedEvent(key));
  }

  void notifyFastError(WhiteException exception) {
    _fastEventStreamController.add(FastErrorEvent(exception));
  }

  void cleanScene() {
    whiteRoom?.cleanScene(false);
  }

  void addPage() {
    whiteRoom?.addPage();
  }

  void prevPage() {
    whiteRoom?.prevPage();
  }

  void nextPage() {
    whiteRoom?.nextPage();
  }

  void setAppliance(FastAppliance fastAppliance) {
    if (fastAppliance == FastAppliance.clear) {
      cleanScene();
      return;
    }
    var state = MemberState()
      ..currentApplianceName = fastAppliance.appliance
      ..shapeType = fastAppliance.shapeType;
    whiteRoom?.setMemberState(state);
  }

  void setStrokeWidth(num strokeWidth) {
    var state = MemberState()..strokeWidth = strokeWidth;
    whiteRoom?.setMemberState(state);
  }

  void setStrokeColor(Color color) {
    var state = MemberState()
      ..strokeColor = [
        color.red,
        color.green,
        color.blue,
      ];
    whiteRoom?.setMemberState(state);
  }

  Future<bool> setWritable(bool writable) async {
    var result = await whiteRoom?.setWritable(writable);
    if (result ?? false) {
      whiteRoom?.disableSerialization(false);
    }
    value = value.copyWith(writable: result);
    return result ?? false;
  }

  void undo() {
    whiteRoom?.undo();
  }

  void redo() {
    whiteRoom?.redo();
  }

  void removePages() {
    whiteRoom?.removeScenes('/');
  }

  void zoomTo(num zoomScale) {
    whiteRoom?.moveCamera(CameraConfig(scale: zoomScale));
  }

  void zoomReset() {
    whiteRoom?.moveCamera(CameraConfig(
      scale: zoomScaleDefault,
      centerX: 0,
      centerY: 0,
    ));
  }

  Future<void> onSdkCreated(WhiteSdk whiteSdk) async {
    this.whiteSdk = whiteSdk;
    await joinRoom();
  }

  Future<void> joinRoom() async {
    try {
      whiteRoom = await whiteSdk?.joinRoom(
        options: fastRoomOptions.roomOptions,
        onRoomPhaseChanged: _onRoomPhaseChanged,
        onRoomStateChanged: _onRoomStateChanged,
        onCanRedoStepsUpdate: _onCanRedoUpdated,
        onCanUndoStepsUpdate: _onCanUndoUpdated,
        onRoomDisconnected: _onRoomDisconnected,
        onRoomKicked: _onRoomKicked,
        onRoomError: _onRoomError,
      );
      value = value.copyWith(isReady: true, roomState: whiteRoom?.state);
      if (fastRoomOptions.roomOptions.isWritable) {
        whiteRoom?.disableSerialization(false);
      }
    } on WhiteException catch (e) {
      debugPrint("joinRoom error ${e.message}");
      notifyFastError(e);
    } catch (e) {
      debugPrint("joinRoom error $e");
    }
  }

  Future<void> reconnect() async {
    value = FastRoomValue.uninitialized(fastRoomOptions.roomOptions.isWritable);
    if (whiteRoom != null) {
      await whiteRoom?.disconnect();
    }
    return joinRoom();
  }

  void insertImage(String url, num width, num height) {
    var info = ImageInformation(width: width, height: height);
    whiteRoom?.insertImageByUrl(info, url);
  }

  Future<String?> insertVideo(String url, String title) async {
    var windowAppParams = WindowAppParams.mediaPlayerApp(url, title);
    return await whiteRoom?.addApp(windowAppParams);
  }

  Future<String?> insertDoc(InsertDocParams params) async {
    if (whiteRoom == null) return null;
    try {
      ConversionQuery query = ConversionQuery(
        taskUUID: params.taskUUID,
        takeToken: params.taskToken,
        convertType:
            params.dynamic ? ConversionType.dynamic : ConversionType.static,
        region: (params.region ?? fastRoomOptions.fastRegion).toRegion(),
      );

      var info = await Converter.instance.startQuery(query);
      var windowAppParams = WindowAppParams.slideApp(
        "/${params.taskUUID}/${whiteRoom?.genUuidV4()}",
        info.toScenes(),
        params.title,
      );
      return await whiteRoom?.addApp(windowAppParams);
    } catch (e) {
      debugPrint("insertDoc error $e");
      return null;
    }
  }

  void _onRoomStateChanged(RoomState newState) {
    value = value.copyWith(roomState: newState);
  }

  /// when reconnected, clear all redoUndoCount
  void _onRoomPhaseChanged(String phase) {
    var redoUndoCount = phase == RoomPhase.connected
        ? const FastRedoUndoCount.initialized()
        : value.redoUndoCount;
    value = value.copyWith(
      roomPhase: phase,
      redoUndoCount: redoUndoCount,
    );
  }

  void _onRoomKicked(String reason) {
    debugPrint("room kicked $reason");
  }

  void _onRoomError(String error) {
    debugPrint("on room error $error");
  }

  void _onRoomDisconnected(String error) {
    debugPrint("room disconnected $error");
  }

  void _onCanRedoUpdated(int redoCount) {
    var redoUndoCount = value.redoUndoCount.copyWith(redoCount: redoCount);
    value = value.copyWith(redoUndoCount: redoUndoCount);
  }

  void _onCanUndoUpdated(int undoCount) {
    var redoUndoCount = value.redoUndoCount.copyWith(undoCount: undoCount);
    value = value.copyWith(redoUndoCount: redoUndoCount);
  }

  @override
  void dispose() {
    super.dispose();
    _fastEventStreamController.close();
  }
}

/// reserved for replay
class FastReplayController {}
