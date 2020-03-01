import PinLayout
import UIKit

public class TodoFormView: UIView {
  let titleTextField = UITextField()

  init() {
    super.init(frame: .zero)

    self.backgroundColor = .white
    titleTextField.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
    addSubview(titleTextField)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    titleTextField.pin.top(pin.safeArea.top + 16).horizontally(16).height(32)
  }
}
