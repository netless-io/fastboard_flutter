import 'fast_region.dart';

class InsertDocParams {
  InsertDocParams({
    required this.taskUUID,
    required this.taskToken,
    required this.dynamic,
    required this.title,
    this.region,
  });

  /// The UUID of the file conversion task.
  /// You can get uuid from the response body when the Start file conversion (POST) API call succeeds.
  final String taskUUID;

  /// The task token of the file conversion task,
  /// which must be the same as the task token that you use to start the file conversion task.
  final String taskToken;

  /// The title of the sub-window.
  final String title;

  /// doc type when conversion created.
  /// mostly
  /// true: for ppt, pptx.
  /// false: for docs, pdf.
  final bool dynamic;

  /// region when conversion created. see [FastRegion] for more info
  final FastRegion? region;
}
