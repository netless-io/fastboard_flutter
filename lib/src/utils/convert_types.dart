enum ServerConvertState {
  waiting,
  converting,
  notFound,
  finished,
  fail,
}

const serverConvertStateMap = <String?, ServerConvertState>{
  "Waiting": ServerConvertState.waiting,
  "Converting": ServerConvertState.converting,
  "NotFound": ServerConvertState.notFound,
  "Finished": ServerConvertState.finished,
  "Fail": ServerConvertState.fail,
};

extension ServerConvertStateStringExtensions on String? {
  ServerConvertState toServerConvertState() {
    return serverConvertStateMap[this] ?? ServerConvertState.converting;
  }
}

class ConversionInfo {
  String uuid;
  String type;
  ServerConvertState status;
  bool? canvasVersion;
  Progress? progress;

  ConversionInfo({
    required this.uuid,
    required this.type,
    required this.status,
    this.canvasVersion,
    this.progress,
  });

  ConversionInfo.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        type = json['type'],
        status = (json['status'] as String?).toServerConvertState(),
        canvasVersion = json['canvasVersion'],
        progress = json['progress'] != null
            ? Progress.fromJson(json['progress'])
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['type'] = type;
    data['status'] = status;
    data['canvasVersion'] = canvasVersion;
    if (progress != null) {
      data['progress'] = progress!.toJson();
    }
    return data;
  }
}

class Progress {
  int? totalPageSize;
  int? convertedPageSize;
  int? convertedPercentage;
  List<ConvertedFileList>? convertedFileList;
  String? currentStep;
  String? prefix;

  Progress({
    this.totalPageSize,
    this.convertedPageSize,
    this.convertedPercentage,
    this.convertedFileList,
    this.currentStep,
    this.prefix,
  });

  Progress.fromJson(Map<String, dynamic> json) {
    totalPageSize = json['totalPageSize'];
    convertedPageSize = json['convertedPageSize'];
    convertedPercentage = json['convertedPercentage'];
    if (json['convertedFileList'] != null) {
      convertedFileList = (json['convertedFileList'] as Iterable).map((v) {
        return ConvertedFileList.fromJson(v);
      }).toList();
    }
    currentStep = json['currentStep'];
    prefix = json['prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalPageSize'] = totalPageSize;
    data['convertedPageSize'] = convertedPageSize;
    data['convertedPercentage'] = convertedPercentage;
    if (convertedFileList != null) {
      data['convertedFileList'] =
          convertedFileList!.map((v) => v.toJson()).toList();
    }
    data['currentStep'] = currentStep;
    data['prefix'] = prefix;
    return data;
  }
}

class ConvertedFileList {
  int? width;
  int? height;
  String? conversionFileUrl;
  String? preview;

  ConvertedFileList({
    this.width,
    this.height,
    this.conversionFileUrl,
    this.preview,
  });

  ConvertedFileList.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    conversionFileUrl = json['conversionFileUrl'];
    preview = json['preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    data['preview'] = preview;
    data['conversionFileUrl'] = conversionFileUrl;
    return data;
  }
}
