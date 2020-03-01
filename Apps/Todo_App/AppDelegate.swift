import Dependency_Realm
import Feature_Todo_List
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    initialRealmConfig()

    let window = UIWindow()
    let rootViewController = UITabBarController()
    rootViewController.viewControllers = [
      UINavigationController(
        rootViewController: TodoListViewController(
          environment: (todoListRepository, routeTodoForm, updateTodoRepository))
      ),
    ]
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
    self.window = window
    return true
  }
}
