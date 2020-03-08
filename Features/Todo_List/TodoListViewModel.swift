import Foundation
import Foundation_Todo_Repository
import Overture
import Prelude
import ReactiveSwift
import UIKit

public struct TodoListViewModelInput {
  var viewDidLoad: Signal<(), Never>
  let viewWillDisappear: Signal<(), Never>
  var onAddTodo: Signal<(), Never>
  var isCompleteChange: Signal<(TodoModel, Bool), Never>
}

public struct TodoListViewModelOutput {
  var todoModels: Signal<RepositorySubscriptionData<[TodoModel]>, Never>
  var routeToAddTodo: Signal<(UIViewController) -> Void, Never>
}

public func todoListViewModel(input: TodoListViewModelInput, environment: TodoListEnvironment)
  -> TodoListViewModelOutput
{
  let (todoListSignal, todoListObserver) = Signal<[TodoModel], Never>.pipe()

  let routeToAddTodo = input.onAddTodo.map(value: environment.onAddTodo)

  environment.todoListRepository.added
    .take(until: input.viewWillDisappear)
    .withLatest(from: todoListSignal)
    .map({ (newTodo, list) -> [TodoModel] in list + [newTodo] })
    .observe(todoListObserver)

  let todoListSubscription = input.viewDidLoad
    .flatMap(.latest, environment.todoListRepository.subscribe)
    .take(until: input.viewWillDisappear)

  input.isCompleteChange
    .observeValues { (todoModel, isCompleted) in
      environment.updateTodoRepository.update(with(todoModel, set(\.isCompleted, isCompleted)))
    }

  return TodoListViewModelOutput(
    todoModels: todoListSubscription,
    routeToAddTodo: routeToAddTodo
  )
}
