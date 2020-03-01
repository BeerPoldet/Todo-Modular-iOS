import Foundation
import Foundation_Todo_Repository
import UIKit

public typealias TodoFormEnvironment = (
  addTodoRepository: AddTodoRepository,
  onDismiss: (UIViewController) -> Void
)
