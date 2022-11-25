#import "AnimatedBottomNavBarPlusPlugin.h"
#if __has_include(<animated_bottom_nav_bar_plus/animated_bottom_nav_bar_plus-Swift.h>)
#import <animated_bottom_nav_bar_plus/animated_bottom_nav_bar_plus-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "animated_bottom_nav_bar_plus-Swift.h"
#endif

@implementation AnimatedBottomNavBarPlusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAnimatedBottomNavBarPlusPlugin registerWithRegistrar:registrar];
}
@end
