import Foundation
import UIKit

final class PFQueryEditorField: UIView, UITextFieldDelegate {
    typealias StringHandler = (String) -> Void
    private let textfield = UITextField()
    let paramName: String
    var value: String?

    private let hStack = UIStackView(axis: .horizontal) {
        $0.spacing = 12
    }

    var onEndEditing: StringHandler?

    init(paramName: String, value: String? = nil) {
        self.paramName = paramName
        self.value = value
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let paramNameLabel = UILabel()
        paramNameLabel.text = paramName + ": "
        paramNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        paramNameLabel.width(80)

        textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        if let value = value {
            textfield.text = value
        } else {
            textfield.placeholder = "Type in value for \"\(paramName)\""
        }

        hStack.addArrangedSubview(paramNameLabel)
        hStack.addArrangedSubview(textfield)

        hStack.embedIn(self, vInset: 10)
    }

    @objc private func textFieldDidChange(_ sender: UITextField) {
        value = sender.text
    }
}
