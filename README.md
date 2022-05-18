# Agora Fastboard SDK

Agora Fastboard SDK is the next generation whiteboard SDK to help developers quickly build
whiteboard applications.

## Getting started

```yaml
dependencies:
    fastboard_flutter: ^0.0.2
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