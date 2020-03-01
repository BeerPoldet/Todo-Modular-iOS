import Foundation

public class UpdateTodoRepository {
  public init(update: @escaping (TodoModel) -> Void) {
    self.update = update
  }

  public var update: (TodoModel) -> Void
}
