import Feature_Todo_List
import Foundation
import Foundation_Todo_Repository
import NeedleFoundation
import UIKit

public protocol TodoListDependency: Dependency {
  var todoListRepository: TodoListRepository { get }
//  var onAddTodo: (UIViewController, UIViewController) -> Void { get }
  var updateTodoRepository: UpdateTodoRepository { get }
}

public class TodoListComponent: Component<TodoListDependency>, TodoListBuilder {
  public var todoListViewController: UIViewController {
    return TodoListViewController(
      environment: TodoListEnvironment(
        dependency.todoListRepository,
        { vc in },
//        { vc in
//          self.dependency.onAddTodo(
//            vc,
//            UINavigationController(
//              rootViewController: self.todoFormComponent.todoFormViewController
//            )
//          )
//        },
        dependency.updateTodoRepository
      )
    )
  }

  var todoFormComponent: TodoFormComponent {
    return TodoFormComponent(parent: self)
  }
}

public protocol TodoListBuilder {
  var todoListViewController: UIViewController { get }
}
