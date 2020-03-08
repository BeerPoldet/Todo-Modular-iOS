import Dependency_Realm
import Feature_Todo_Form
import Feature_Todo_List
import Foundation
import Foundation_Todo_Repository
import Overture
import Prelude
import UIKit

struct AppDependency {
  let todoListRepository: TodoListRepository
  let addTodoRepository: AddTodoRepository
  let updateTodoRepository: UpdateTodoRepository
  let rootViewController: () -> UIViewController
}

extension AppDependency {
  static func resolve() -> AppDependency {
    let todoListRepository = Dependency_Realm.todoListRepository
    let addTodoRepository = Dependency_Realm.addTodoRepository
    let updateTodoRepository = Dependency_Realm.updateTodoRepository

    let createAddTodoViewController: () -> UIViewController = {
      TodoFormEnvironment(
        addTodoRepository: addTodoRepository,
        onDismiss: dismissViewController
      )
        |> TodoFormViewController.init(environment:)
        >>> UINavigationController.init(rootViewController:)
    }

    let createRootViewController: () -> UIViewController = {
      TodoListEnvironment(
        todoListRepository: todoListRepository,
        onAddTodo: { vc in
          presentViewController(
            presenting: vc,
            presented: createAddTodoViewController()
          )
        },
        updateTodoRepository: updateTodoRepository
      )
        |> TodoListViewController.init(environment:)
        >>> UINavigationController.init(rootViewController:)
    }

    return AppDependency(
      todoListRepository: todoListRepository,
      addTodoRepository: addTodoRepository,
      updateTodoRepository: updateTodoRepository,
      rootViewController: createRootViewController
    )
  }
}
