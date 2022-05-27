# Agora Fastboard SDK
[![Version](https://img.shields.io/pub/v/fastboard_flutter.svg)](https://pub.dev/packages/fastboard_flutter)
[![Generic badge](https://img.shields.io/badge/platform-android%20|%20ios%20-blue.svg)](https://pub.dev/packages/fastboard_flutter)

Agora Fastboard SDK is the next generation whiteboard SDK to help developers quickly build
whiteboard applications.

## Getting started

```yaml
dependencies:
    fastboard_flutter: ^0.0.3
```

## Usage

```dart
  Widget build(BuildContext context) {
    return Stack(children: [
        FastRoomWidget(
            fastRoomOptions: FastRoomOptions(
                appId: APP_ID,
                uuid: ROOM_UUID,
                token: ROOM_TOKEN,
                uid: UNIQUE_CLIENT_ID,
                writable: true,
                fastRegion: FastRegion.cn_hz,
            ),
            onFastRoomCreated: onFastRoomCreated,
        ),
    ]);
}

```