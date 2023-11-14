import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let googleMapsKey = getPlist(withName: "GoogleMapsAPIKey")
    GMSServices.provideAPIKey(googleMapsKey ?? " ")
  
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}


func getPlist(withName name: String) -> String?
{
    if let path = Bundle.main.path(forResource: name, ofType: "plist"),
       let xml = FileManager.default.contents(atPath: path)
    {
        let plistData = try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil)
        print(plistData)
        return (plistData) as? String
    }
    return nil
}