import Dependency_Realm
import Feature_Todo_List
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  let dependency: AppDependency = AppDependency.resolve()

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    initialRealmConfig()

    let window = UIWindow()
    window.rootViewController = dependency.rootViewController()
    window.makeKeyAndVisible()
    self.window = window
    return true
  }
}
