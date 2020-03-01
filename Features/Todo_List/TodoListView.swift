import PinLayout
import UIKit

public class TodoListView: UIView {
  let tableView = UITableView()

  init() {
    super.init(frame: .zero)

    addSubview(tableView)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    tableView.pin.all()
  }
}
