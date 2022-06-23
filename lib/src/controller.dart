import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

import 'fastboard.dart';
import 'types/types.dart';
import 'utils/converter.dart';

/// Control a [FastRoomView].
///
/// A [FastRoomController] instance can be obtained by setting the [FastRoomView.onFastRoomCreated]
/// callback for a [FastRoomView] widget.
class FastRoomController extends ValueNotifier<FastRoomValue> {
  FastRoomController(this.fastRoomOptions)
      : super(FastRoomValue.uninitialized(fastRoomOptions.writable)) {
    containerSizeRatio = fastRoomOptions.containerSizeRatio;
  }

  /// whiteboard_flutter [WhiteSdk] instance, export for specific usage
  WhiteSdk? whiteSdk;

  /// whiteboard_flutter [WhiteRoom] instance, export for specific usage
  WhiteRoom? whiteRoom;

  FastRoomOptions fastRoomOptions;
  double? containerSizeRatio;

  num zoomScaleDefault = 1;
  Size? roomLayoutSize;
  bool? useDarkTheme;

  double? get ratioWhenNull {
    if (roomLayoutSize == null) {
      return null;
    }
    return roomLayoutSize!.height / roomLayoutSize!.width;
  }

  final StreamController<FastRoomEvent> _fastEventStreamController =
      StreamController<FastRoomEvent>.broadcast();

  /// The fast room overlay has changed.
  /// overlay is room extension operation view.
  Stream<OverlayChangedEvent> onOverlayChanged() {
    return _fastEventStreamController.stream.whereType<OverlayChangedEvent>();
  }

  /// The fast room cause a error.
  Stream<FastErrorEvent> onError() {
    return _fastEventStreamController.stream.whereType<FastErrorEvent>();
  }

  /// The fast room view size has changed.
  Stream<SizeChangedEvent> onSizeChanged() {
    return _fastEventStreamController.stream.whereType<SizeChangedEvent>();
  }

  void changeOverlay(int key) {
    _fastEventStreamController.add(OverlayChangedEvent(key));
  }

  void notifyFastError(WhiteException exception) {
    _fastEventStreamController.add(FastErrorEvent(exception));
  }

  void notifySizeChanged(Size size) {
    _fastEventStreamController.add(SizeChangedEvent(size));
  }

  /// clean current scene. bath paint element (line, text, etc.) and image
  void cleanScene() {
    whiteRoom?.cleanScene(false);
  }

  /// add a page current scene dir.
  void addPage() {
    whiteRoom?.addPage();
  }

  /// change to preview page.
  void prevPage() {
    whiteRoom?.prevPage();
  }

  /// change to next page;
  void nextPage() {
    whiteRoom?.nextPage();
  }

  /// remove all pages.
  void removePages() {
    whiteRoom?.removeScenes('/');
  }

  /// sets the whiteboard tool currently in use. all tools see [FastAppliance].
  /// when [fastAppliance] is [FastAppliance.clear], clean scene paint element.
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

  /// sets element paint stroke width to [strokeWidth].
  void setStrokeWidth(num strokeWidth) {
    var state = MemberState()..strokeWidth = strokeWidth;
    whiteRoom?.setMemberState(state);
  }

  /// sets element paint stroke color to [color].
  void setStrokeColor(Color color) {
    var state = MemberState()
      ..strokeColor = [
        color.red,
        color.green,
        color.blue,
      ];
    whiteRoom?.setMemberState(state);
  }

  /// sets whether the user is in interactive mode in the room.
  /// true: interactive mode, that is, with read and write permissions.
  /// false: subscription mode, that is, with read-only permission.
  Future<bool> setWritable(bool writable) async {
    var result = await whiteRoom?.setWritable(writable) ?? false;
    value = value.copyWith(writable: result);
    if (result) {
      whiteRoom?.disableSerialization(false);
    }
    return result;
  }

  /// undoes an undone action.
  void undo() {
    whiteRoom?.undo();
  }

  /// redoes an undone action.
  void redo() {
    whiteRoom?.redo();
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

  Future<void> joinRoomWithSdk(WhiteSdk whiteSdk) async {
    this.whiteSdk = whiteSdk;
    await joinRoom();
  }

  /// joins the whiteboard room.
  Future<void> joinRoom() async {
    try {
      whiteRoom = await whiteSdk?.joinRoom(
        options: fastRoomOptions.genRoomOptions(
            ratioWhenNull: ratioWhenNull,
            prefersColorScheme: useDarkTheme ?? false
                ? WindowPrefersColorScheme.dark
                : WindowPrefersColorScheme.light),
        onRoomPhaseChanged: _onRoomPhaseChanged,
        onRoomStateChanged: _onRoomStateChanged,
        onCanRedoStepsUpdate: _onCanRedoUpdated,
        onCanUndoStepsUpdate: _onCanUndoUpdated,
        onRoomDisconnected: _onRoomDisconnected,
        onRoomKicked: _onRoomKicked,
        onRoomError: _onRoomError,
      );
      value = value.copyWith(isReady: true, roomState: whiteRoom?.state);
      if (fastRoomOptions.writable) {
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
    value = FastRoomValue.uninitialized(fastRoomOptions.writable);
    if (whiteRoom != null) {
      await whiteRoom?.disconnect();
    }
    return joinRoom();
  }

  /// insert a [url] image with whiteboard size ([width], [height])
  /// at whiteboard center point (0, 0)
  void insertImage(String url, num width, num height) {
    var info = ImageInformation(width: width, height: height);
    whiteRoom?.insertImageByUrl(info, url);
  }

  /// insert a video or audio with [url] into sub_window.
  /// window app display [title].
  Future<String?> insertVideo(String url, String title) async {
    var windowAppParams = WindowAppParams.mediaPlayerApp(url, title);
    return await whiteRoom?.addApp(windowAppParams);
  }

  /// insert a doc([InsertDocParams]) into sub_window.
  /// window app display [InsertDocParams.title].
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

  void setContainerSizeRatio(double ratio) {
    containerSizeRatio = ratio;
    whiteRoom?.setContainerSizeRatio(ratio);
  }

  void updateRoomLayoutSize(Size size) {
    roomLayoutSize = size;
    if (containerSizeRatio == null) {
      whiteRoom?.setContainerSizeRatio(size.height / size.width);
    }
    notifySizeChanged(size);
  }

  void updateThemeData(bool useDarkTheme, FastThemeData themeData) {
    this.useDarkTheme = useDarkTheme;
    whiteSdk?.setBackgroundColor(themeData.backgroundColor);
    whiteRoom?.setPrefersColorScheme(useDarkTheme
        ? WindowPrefersColorScheme.dark
        : WindowPrefersColorScheme.light);
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
