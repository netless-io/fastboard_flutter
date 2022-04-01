import 'dart:async';

import 'package:fastboard_flutter/src/types/fast_redo_undo_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

import 'types/types.dart';

class FastRoomController extends ValueNotifier<FastRoomValue> {
  FastRoomController(this.fastRoomOptions)
      : super(FastRoomValue.uninitialized(fastRoomOptions.writable));

  WhiteSdk? whiteSdk;
  WhiteRoom? whiteRoom;
  FastRoomOptions fastRoomOptions;

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

  // TODO 同时开启序列化
  Future<bool?> setWritable(bool writable) async {
    var result = await whiteRoom?.setWritable(writable);
    if (result ?? false) {
      whiteRoom?.disableSerialization(false);
      return true;
    } else {
      return false;
    }
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

  Future<void> onSdkCreated(WhiteSdk whiteSdk) async {
    this.whiteSdk = whiteSdk;
    await joinRoom();
  }

  Future<void> joinRoom() async {
    whiteRoom = await whiteSdk?.joinRoom(
      options: fastRoomOptions.roomOptions,
      onRoomPhaseChanged: _onRoomPhaseChanged,
      onRoomStateChanged: _onRoomStateChanged,
      onCanRedoStepsUpdate: _onCanRedoUpdated,
      onCanUndoStepsUpdate: _onCanUndoUpdated,
      onRoomDisconnected: _onRoomDisconnected,
      onRoomError: _onRoomError,
    );
    if (fastRoomOptions.roomOptions.isWritable) {
      whiteRoom?.disableSerialization(false);
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
    value = value.copyWith(roomPhase: phase, redoUndoCount: redoUndoCount);
  }

  void _onRoomError(String error) {}

  void _onRoomDisconnected(String error) {}

  void _onCanRedoUpdated(int redoCount) {
    var redoUndoCount = value.redoUndoCount.copyWith(redoCount: redoCount);
    value = value.copyWith(redoUndoCount: redoUndoCount);
  }

  void _onCanUndoUpdated(int undoCount) {
    var redoUndoCount = value.redoUndoCount.copyWith(undoCount: undoCount);
    value = value.copyWith(redoUndoCount: redoUndoCount);
  }
}

class FastReplayController {}
