import Flutter
import UIKit

public class ReadTextContentFromUriPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.jimdo.uchida001tmhr/read_text_content_from_uri", binaryMessenger: registrar.messenger())
    let instance = ReadTextContentFromUriPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "execute":
      if let args = call.arguments as? Dictionary<String, String>,
         let pathString = (args["UriString"])?.replacingOccurrences(of: "file://", with: ""),
         let fileContents = try? String(contentsOf: URL(fileURLWithPath: pathString)) {
        result(fileContents)
      } else {
        result("File read error")
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
