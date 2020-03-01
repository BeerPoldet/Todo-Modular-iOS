import Feature_Todo_Form
import Foundation
import Foundation_Todo_Repository
import NeedleFoundation
import UIKit

public protocol TodoFormDependency: Dependency {
  var addTodoRepository: AddTodoRepository { get }
  var onDismiss: (UIViewController) -> Void { get }
}

public class TodoFormComponent: Component<TodoFormDependency>, TodoFormBuilder {
  public var todoFormViewController: UIViewController {
    return TodoFormViewController(
      environment: TodoFormEnvironment(dependency.addTodoRepository, dependency.onDismiss)
    )
  }
}

public protocol TodoFormBuilder {
  var todoFormViewController: UIViewController { get }
}
