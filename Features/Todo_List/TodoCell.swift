import PinLayout
import ReactiveSwift
import UIKit

public class TodoCell: UITableViewCell {
  public let label = UILabel()
  public let completeSwitch = UISwitch()
  public let dispose = SerialDisposable()

  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.contentView.addSubview(label)
    self.contentView.addSubview(completeSwitch)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func layoutSubviews() {
    super.layoutSubviews()

    label.pin
      .start(16)
      .vCenter()
      .marginRight(8)
      .sizeToFit(.widthFlexible)
      .before(of: completeSwitch)
    completeSwitch.pin
      .vertically(8)
      .end(16)
  }
}

extension String {
  public static let cell_todo = "todo-cell"
}
