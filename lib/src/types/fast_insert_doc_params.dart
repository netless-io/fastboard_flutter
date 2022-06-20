import 'fast_region.dart';

class InsertDocParams {
  InsertDocParams({
    required this.taskUUID,
    required this.taskToken,
    required this.dynamic,
    required this.title,
    this.region,
  });

  final String taskUUID;

  final String taskToken;

  final String title;

  final bool dynamic;

  final FastRegion? region;
}
