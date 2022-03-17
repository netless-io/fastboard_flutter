#import "FastboardFlutterPlugin.h"
#if __has_include(<fastboard_flutter/fastboard_flutter-Swift.h>)
#import <fastboard_flutter/fastboard_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fastboard_flutter-Swift.h"
#endif

@implementation FastboardFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFastboardFlutterPlugin registerWithRegistrar:registrar];
}
@end
