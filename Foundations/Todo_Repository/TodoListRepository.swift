import Foundation
import Overture
import ReactiveSwift

public class TodoListRepository {
  public init(
    list: @escaping () -> [TodoModel],
    added: Signal<TodoModel, Never>,
    updated: Signal<TodoModel, Never>,
    subscribe: @escaping () -> SignalProducer<RepositorySubscriptionData<[TodoModel]>, Never>
  ) {
    self.list = list
    self.added = added
    self.updated = updated
    self.subscribe = subscribe
  }

  public var list: () -> [TodoModel]
  public var added: Signal<TodoModel, Never>
  public var updated: Signal<TodoModel, Never>
  public var subscribe: () -> SignalProducer<RepositorySubscriptionData<[TodoModel]>, Never>
}

public enum RepositorySubscriptionData<T> {
  case initial(T)
  case changes(T, deletions: [Int], insertions: [Int], modifications: [Int])
  case error(Error)
}

public func fmapSubscription<A, B>(_ f: @escaping (A) -> B) -> (RepositorySubscriptionData<A>) ->
  RepositorySubscriptionData<B>
{
  { fa in
    switch fa {
    case let .initial(a):
      return .initial(f(a))
    case let .changes(a, deletions, insertions, modifications):
      return .changes(
        f(a), deletions: deletions, insertions: insertions, modifications: modifications)
    case let .error(error):
      return .error(error)
    }
  }
}
