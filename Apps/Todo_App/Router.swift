import Dependency_Realm
import Feature_Todo_Form
import Foundation
import Prelude
import UIKit

public func routeTodoForm(viewController: UIViewController) {
  (addTodoRepository, dismissViewController)
    |> TodoFormViewController.init(environment:)
    >>> UINavigationController.init(rootViewController:)
    >>> { viewController.present($0, animated: true) }
}

public func presentViewController(
  presenting: UIViewController,
  presented: UIViewController
) {
  presenting.present(presented, animated: true)
}

public func dismissViewController(_ viewController: UIViewController) {
  viewController.dismiss(animated: true)
}
