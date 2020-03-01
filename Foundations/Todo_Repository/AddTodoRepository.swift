import Foundation

public class AddTodoRepository {
  public init(add: @escaping (AddTodoModel) -> Void) {
    self.add = add
  }

  public var add: (AddTodoModel) -> Void
}
