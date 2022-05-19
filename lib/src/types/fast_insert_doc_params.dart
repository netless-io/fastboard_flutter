import 'fast_region.dart';

class InsertDocParams {
  InsertDocParams({
    required this.taskUUID,
    required this.taskToken,
    required this.region,
    required this.dynamic,
    required this.title,
  });

  final String taskUUID;

  final String taskToken;

  final FastRegion region;

  final String title;

  final bool dynamic;
}
