import Foundation
import Foundation_Todo_Repository
import Overture
import Prelude
import ReactiveSwift
import RealmSwift

class TodoRealm: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var title: String = ""
  @objc dynamic var isCompleted: Bool = false

  override static func primaryKey() -> String? {
    return "id"
  }
}

private func todoModel(todoRealm: TodoRealm) -> TodoModel {
  TodoModel(id: todoRealm.id, title: todoRealm.title, isCompleted: todoRealm.isCompleted)
}

let (todoAddedSignal, todoAddedObserver) = Signal<TodoModel, Never>.pipe()
let (todoUpdatedSignal, todoUpdatedObserver) = Signal<TodoModel, Never>.pipe()

public let todoListRepository = TodoListRepository(
  list: {
    let realm = try! Realm()
    return realm.objects(TodoRealm.self).map(todoModel(todoRealm:))
  }, added: todoAddedSignal)

public let addTodoRepository = AddTodoRepository(
  add: { addTodoModel in
    let realm = try! Realm()
    try! realm.write {
      let todoRealm = update(
        TodoRealm(),
        mut(\.title, addTodoModel),
        mut(\.isCompleted, false)
      )
      realm.add(todoRealm)
      todoAddedObserver.send(value:) <| todoModel(todoRealm: todoRealm)
    }
  })

public let updateTodoRepository = UpdateTodoRepository(
  update: { todoModel in
    let realm = try! Realm()
    try! realm.write {
      realm.add(
        update(
          TodoRealm(),
          mut(\.id, todoModel.id),
          mut(\.title, todoModel.title),
          mut(\.isCompleted, todoModel.isCompleted)
        ),
        update: .modified
      )
      todoUpdatedObserver.send(value: todoModel)
    }
  })
