import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

import '../utils/convert_types.dart';

extension ConversionInfoExtensions on ConversionInfo {
  List<Scene> toScenes() {
    var result = <Scene>[];

    /// workaround for no List.mapIndexed
    List<ConvertedFileList>? converted = progress?.convertedFileList;
    if (converted != null) {
      for (var index = 0; index < converted.length; index++) {
        var elem = converted[index];
        result.add(Scene(
          name: "${index + 1}",
          ppt: WhiteBoardPpt(
            src: elem.conversionFileUrl!,
            height: elem.height!,
            width: elem.width!,
            previewURL: elem.preview,
          ),
        ));
      }
    }

    return result;
  }
}
