import Foundation
import Foundation_Todo_Repository
import Prelude
import ReactiveSwift
import UIKit

public struct TodoFormViewModelInput {
  var viewDidLoad: Signal<(), Never>
  var onSubmitAddTodo: Signal<(), Never>
  var onTextChange: Signal<String, Never>
}

public struct TodoFormViewModelOutput {
  var onDismiss: Signal<(UIViewController) -> Void, Never>
}

public func todoFormViewModel(input: TodoFormViewModelInput, environment: TodoFormEnvironment)
  -> TodoFormViewModelOutput
{
  let submitTodo = input.onSubmitAddTodo.withLatest(from: input.onTextChange)
    .map({ $0.1 })

  submitTodo
    .observeValues(environment.addTodoRepository.add)

  return TodoFormViewModelOutput(onDismiss: submitTodo.map(value: environment.onDismiss))
}
