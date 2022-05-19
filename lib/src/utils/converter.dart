import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'convert_types.dart';

enum ConversionType {
  static,
  dynamic,
}

class RetryPolicy {
  RetryPolicy({
    this.maxAttempts = 3,
  });

  final int maxAttempts;

  int retryCount = 0;

  bool canRetry() {
    return retryCount < maxAttempts;
  }

  void inc() {
    retryCount++;
  }
}

extension ConversionTypeExtensions on ConversionType {
  String serialize() {
    switch (this) {
      case ConversionType.static:
        return "static";
      case ConversionType.dynamic:
        return "dynamic";
    }
  }
}

extension ConversionTypeStringExtensions on String? {
  ConversionType toConversionType() {
    var conversionTypeMap = <String?, ConversionType>{
      "static": ConversionType.static,
      "dynamic": ConversionType.dynamic,
    };
    return conversionTypeMap[this] ?? ConversionType.static;
  }
}

typedef ConvertProgressCallback = void Function(
    num progress, ConversionInfo info);
typedef ConvertFinishedCallback = void Function(ConversionInfo info);

class ConversionQuery {
  const ConversionQuery({
    required this.taskUUID,
    required this.takeToken,
    required this.convertType,
    required this.region,
    this.onProgress,
    this.onFinished,
    this.interval = 1 * 1000,
    this.maxAttempts = 3,
  });

  final String taskUUID;

  final String takeToken;

  final String region;

  final ConversionType convertType;

  /// milliseconds of one retry
  final int interval;

  /// max retry time
  final int maxAttempts;

  final ConvertProgressCallback? onProgress;

  final ConvertFinishedCallback? onFinished;
}

abstract class ProgressCallback {}

class Converter {
  Converter._internal();

  static final Converter _instance = Converter._internal();

  static Converter get instance => _instance;

  var httpClient = HttpClient();

  Future<ConversionInfo> startQuery(ConversionQuery query) async {
    Completer<ConversionInfo> completer = Completer();

    RetryPolicy retryPolicy = RetryPolicy(maxAttempts: query.maxAttempts);
    Future.doWhile(() async {
      bool keepGoing = false;
      var info = await _requestQuery(query);
      if (info != null) {
        switch (info.status) {
          case ServerConvertState.notFound:
          case ServerConvertState.fail:
            completer.completeError("file not found or error");
            keepGoing = false;
            break;
          case ServerConvertState.finished:
            completer.complete(info);
            keepGoing = false;
            break;
          case ServerConvertState.waiting:
          case ServerConvertState.converting:
            keepGoing = retryPolicy.canRetry();
            break;
        }
      } else {
        keepGoing = retryPolicy.canRetry();
      }
      if (keepGoing) {
        await Future<void>.delayed(Duration(milliseconds: query.interval));
        retryPolicy.inc();
      } else {
        if (!retryPolicy.canRetry()) {
          completer.completeError("times out");
        }
      }
      return keepGoing;
    });
    return completer.future;
  }

  /// null for status code error
  Future<ConversionInfo?> _requestQuery(ConversionQuery query) async {
    var queryUri = Uri(
      scheme: "https",
      host: "api.netless.link",
      path: "v5/services/conversion/tasks/${query.taskUUID}",
      queryParameters: {
        "type": query.convertType.serialize(),
      },
    );

    var request = await httpClient.getUrl(queryUri);
    request.headers.add("token", query.takeToken);
    request.headers.add("region", query.region);
    request.headers.add("Content-Type", "application/json");
    request.headers.add("Accept", "application/json");

    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      String responseBody = await response.transform(utf8.decoder).join();
      var json = jsonDecode(responseBody);
      return ConversionInfo.fromJson(json);
    } else {
      return null;
    }
  }
}
