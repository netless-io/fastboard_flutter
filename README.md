# Agora Fastboard

[![Version](https://img.shields.io/pub/v/fastboard_flutter.svg)](https://pub.dev/packages/fastboard_flutter)
[![Generic badge](https://img.shields.io/badge/platform-android%20|%20ios%20-blue.svg)](https://pub.dev/packages/fastboard_flutter)

Agora Fastboard SDK is the latest generation of the whiteboard SDK launched by Agora to help
developers quickly build whiteboard applications. It simplifies the APIs of the Whiteboard SDK and
adds UI implementations. These improvements enable you to join a room with just a few lines of code
and instantly experience real-time interactive collaboration using a variety of rich editing tools.
It is pinned on the following features

* Low-cost
* Scenario-based
* Configurable

## Getting started

In your flutter project add the dependency:

```yaml
dependencies:
    fastboard_flutter: ^0.1.0
```

## Usage

see
example [quick_start](example/lib/quick_start.dart) [custom_layout](example/lib/custom_layout.dart)

### FastRoomView

See the `example` directory for a minimal example of how to use FastRoomView, embed `FastRoomView`
to your app.

```dart
@override
Widget build(BuildContext context) {
  return Stack(children: [
    FastRoomView(fastRoomOptions: FastRoomOptions(
      appId: APP_ID,
      uuid: ROOM_UUID,
      token: ROOM_TOKEN,
      uid: UNIQUE_CLIENT_ID,
      writable: true,
      fastRegion: FastRegion.cn_hz,
    )),
    useDarkTheme = true,
  ]);
}

```

### DarkMode

Fastboard has a built-in set of dark mode configuration, you can switch between dark mode and light
mode by configuring useDarkTheme.

```dart
@override
Widget build(BuildContext context) {
  return Stack(children: [
    FastRoomView(fastRoomOptions: FastRoomOptions(
      appId: APP_ID,
      uuid: ROOM_UUID,
      token: ROOM_TOKEN,
      uid: UNIQUE_CLIENT_ID,
      writable: true,
      fastRegion: FastRegion.cn_hz,
    )),
    useDarkTheme = true,
  ]);
}
```

Also you can config `FastRoomView.theme`, `FastRoomView.darkTheme` to change colors of built-in
Widgets. see [FastThemeData](lib/src/types/fast_theme_data.dart)

```dart
@override
Widget build(BuildContext context) {
  return Stack(children: [
    FastRoomView(fastRoomOptions: FastRoomOptions(
      appId: APP_ID,
      uuid: ROOM_UUID,
      token: ROOM_TOKEN,
      uid: UNIQUE_CLIENT_ID,
      writable: true,
      fastRegion: FastRegion.cn_hz,
    )),
    theme: FastThemeData.light().copyWith(mainColor: Color(0xFF00BCD4)),
    darkTheme: FastThemeData.dark().copyWith(mainColor: Color(0xFF0097A7)),
    useDarkTheme = true,
  ]);
}
```

### RoomControllerWidgetBuilder

hide/show built-in widgets, or customize widget use `FastRoomView.builder`
see [example](example/lib/custom_layout.dart)

```dart
@override
Widget build(BuildContext context) {
  return Stack(children: [
    FastRoomView(fastRoomOptions: FastRoomOptions(
      appId: APP_ID,
      uuid: ROOM_UUID,
      token: ROOM_TOKEN,
      uid: UNIQUE_CLIENT_ID,
      writable: true,
      fastRegion: FastRegion.cn_hz,
    )),
    builder: customBuilder,
  ]);
}

Widget customBuilder(BuildContext context, FastRoomController controller) {
  return Stack(
    alignment: Alignment.center,
    children: [
      FastOverlayHandlerView(controller),
      Positioned(
        child: FastPageIndicator(controller),
        bottom: FastGap.gap_3,
        right: FastGap.gap_3,
      ),
      FastToolBoxExpand(controller),
      FastStateHandlerView(controller),
    ],
  );
}
```

### ToolBox Items

you can configure ToolBox appliances by `FastUiSettings.toolboxItems`

```dart
void main() {
  FastUiSettings.toolboxItems = [
    ToolboxItem(appliances: [FastAppliance.clicker]),
    ToolboxItem(appliances: [FastAppliance.selector]),
    ToolboxItem(appliances: [FastAppliance.pencil]),
    ToolboxItem(appliances: [FastAppliance.eraser]),
    ToolboxItem(appliances: [
      FastAppliance.rectangle,
      FastAppliance.ellipse,
      FastAppliance.straight,
      FastAppliance.arrow,
      FastAppliance.pentagram,
      FastAppliance.rhombus,
      FastAppliance.triangle,
      FastAppliance.balloon,
    ]),

    /// remove FastAppliance.clear
    /// ToolboxItem(appliances: [FastAppliance.clear]),
  ];
  runApp(const MyApp());
}
```