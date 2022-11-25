import Flutter
import UIKit

public class SwiftAnimatedBottomNavBarPlusPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "animated_bottom_nav_bar_plus", binaryMessenger: registrar.messenger())
    let instance = SwiftAnimatedBottomNavBarPlusPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
