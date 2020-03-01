import Foundation_Todo_Repository
import PinLayout
import ReactiveCocoa
import ReactiveSwift
import UIKit

public class TodoListViewController: UIViewController {
  let rootView = TodoListView()

  var todos: [TodoModel] = []

  let viewDidLoadProperty = MutableProperty(())
  let onAddTodoProperty = MutableProperty(())

  let (isCompleteChangeSignal, isCompleteChangeObserver) = Signal<(TodoModel, Bool), Never>.pipe()

  public init(environment: TodoListEnvironment) {
    let output = todoListViewModel(
      input: TodoListViewModelInput(
        viewDidLoad: viewDidLoadProperty.signal,
        onAddTodo: onAddTodoProperty.signal,
        isCompleteChange: isCompleteChangeSignal
      ),
      environment: environment
    )
    super.init(nibName: nil, bundle: nil)

    output.todoModels.observeValues({ [weak self] in
      self?.todos = $0
      self?.rootView.tableView.reloadData()
    })

    output.routeToAddTodo.observeValues { [weak self] (route) in
      self.map(route)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func loadView() {
    view = rootView
  }

  override public func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "Todo"
    navigationItem.largeTitleDisplayMode = .always
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add, target: self, action: #selector(onAddTodo))
    rootView.tableView.register(TodoCell.self, forCellReuseIdentifier: .cell_todo)
    rootView.tableView.dataSource = self

    viewDidLoadProperty.value = ()
  }

  @objc public func onAddTodo() {
    onAddTodoProperty.value = ()
  }
}

extension TodoListViewController: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: .cell_todo, for: indexPath)
    if let todoCell = cell as? TodoCell {
      let dispose = CompositeDisposable()
      let todo = todos[indexPath.row]
      todoCell.label.text = todo.title
      todoCell.completeSwitch.isOn = todo.isCompleted
      dispose += todoCell.completeSwitch.reactive
        .isOnValues
        .map({ (todo, $0) })
        .observe(isCompleteChangeObserver)
      todoCell.dispose.inner = dispose
    }
    return cell
  }

  public func numberOfSections(in tableView: UITableView) -> Int {
    1
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    todos.count
  }
}
