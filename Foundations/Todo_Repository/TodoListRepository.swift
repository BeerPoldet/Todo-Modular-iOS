import Foundation
import ReactiveSwift

public class TodoListRepository {
  public init(list: @escaping () -> [TodoModel], added: Signal<TodoModel, Never>) {
    self.list = list
    self.added = added
  }

  public var list: () -> [TodoModel]
  public var added: Signal<TodoModel, Never>
}
