import Foundation_Todo_Repository
import PinLayout
import ReactiveCocoa
import ReactiveSwift
import UIKit

public class TodoFormViewController: UIViewController {
  let rootView = TodoFormView()

  let viewDidLoadProperty = MutableProperty(())
  let onSubmitAddTodo = MutableProperty(())

  public init(environment: TodoFormEnvironment) {
    let output = todoFormViewModel(
      input: TodoFormViewModelInput(
        viewDidLoad: viewDidLoadProperty.signal,
        onSubmitAddTodo: onSubmitAddTodo.signal,
        onTextChange: rootView.titleTextField.reactive.continuousTextValues
      ),
      environment: environment
    )

    super.init(nibName: nil, bundle: nil)

    output.onDismiss.observeValues({ [weak self] in
      self.map($0)
    })
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
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .save, target: self, action: #selector(onSaveTodo))

    viewDidLoadProperty.value = ()
  }

  @objc public func onSaveTodo() {
    onSubmitAddTodo.value = ()
  }
}
