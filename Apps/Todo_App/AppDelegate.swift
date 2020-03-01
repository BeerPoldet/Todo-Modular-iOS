import Dependency_Realm
import Feature_Todo_List
import NeedleFoundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    registerProviderFactories()
    initialRealmConfig()

    let window = UIWindow()
    let rootViewController = RootComponent().createRootViewController
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
    self.window = window
    return true
  }
}
