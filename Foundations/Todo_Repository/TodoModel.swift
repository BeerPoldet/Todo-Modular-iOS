import Foundation

public struct TodoModel {
  public init(id: String, title: String, isCompleted: Bool) {
    self.id = id
    self.title = title
    self.isCompleted = isCompleted
  }

  public var id: String
  public var title: String
  public var isCompleted: Bool
}

public typealias AddTodoModel = String
