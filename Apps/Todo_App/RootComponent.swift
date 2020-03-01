import Dependency_Realm
import Feature_Todo_Form
import Feature_Todo_List
import Foundation
import Foundation_Todo_Repository
import NeedleFoundation
import Overture
import UIKit

class RootComponent: BootstrapComponent {
  var createRootViewController: UIViewController {
    update(
      UITabBarController(),
      {
        $0.viewControllers = [
          UINavigationController(
            rootViewController: self.todoListComponent.todoListViewController
          ),
        ]
      }
    )
  }

  var todoListComponent: TodoListComponent {
    return TodoListComponent(parent: self)
  }

  var todoListRepository: TodoListRepository = Dependency_Realm.todoListRepository
  var updateTodoRepository: UpdateTodoRepository = Dependency_Realm.updateTodoRepository
  var addTodoRepository: AddTodoRepository = Dependency_Realm.addTodoRepository
  var onDismiss: (UIViewController) -> Void = dismissViewController(_:)
}
