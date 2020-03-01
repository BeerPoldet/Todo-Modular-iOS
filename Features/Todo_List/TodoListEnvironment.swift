import Foundation
import Foundation_Todo_Repository
import UIKit

public typealias TodoListEnvironment = (
  todoListRepository: TodoListRepository,
  onAddTodo: (UIViewController) -> Void,
  updateTodoRepository: UpdateTodoRepository
)
