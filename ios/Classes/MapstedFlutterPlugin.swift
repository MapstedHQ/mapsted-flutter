import Flutter
import UIKit

public class MapstedFlutterPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "mapsted_flutter", binaryMessenger: registrar.messenger())
        let instance = MapstedFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "launchMapActivity":
            launchMapActivity()
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func launchMapActivity() {
        DispatchQueue.main.async {
            self._launchMapActivity()
        }
    }
    
    func _launchMapActivity() {
        let storyboard = UIStoryboard(name: "RNMapsted", bundle: Bundle(for: MapstedFlutterPlugin.self))
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "MAPSTEDPROPLISTVC") as? UIViewController else {
            print("Error: Failed to instantiate view controller.")
            return
        }
        
        viewController.modalPresentationStyle = .overCurrentContext
        
        var topViewController = UIApplication.shared.keyWindow?.rootViewController
        while let presentedViewController = topViewController?.presentedViewController {
            topViewController = presentedViewController
        }
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .overCurrentContext
        topViewController?.present(navController, animated: true, completion: nil)
    }
}
