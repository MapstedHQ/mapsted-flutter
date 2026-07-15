//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<integration_test/IntegrationTestPlugin.h>)
#import <integration_test/IntegrationTestPlugin.h>
#else
@import integration_test;
#endif

#if __has_include(<mapsted_flutter/MapstedFlutterPlugin.h>)
#import <mapsted_flutter/MapstedFlutterPlugin.h>
#else
@import mapsted_flutter;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [IntegrationTestPlugin registerWithRegistrar:[registry registrarForPlugin:@"IntegrationTestPlugin"]];
  [MapstedFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"MapstedFlutterPlugin"]];
}

@end
