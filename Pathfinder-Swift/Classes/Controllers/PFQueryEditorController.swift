import Foundation
import UIKit

final class PFQueryEditorController: UIViewController {
    private var config: UrlSpec?

    public var onClose: (() -> Void)?

    private let vStack: UIStackView = UIStackView(axis: .vertical) {
        $0.distribution = .fillEqually
    }

    convenience init(config: UrlSpec) {
        self.init()
        self.config = config
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    private func setupViews() {

        guard let config = config else { return }
        let iconView = UIImageView()
        iconView.image = nil
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = config.name
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        label.height(50)

        let descriptionStack = UIStackView(axis: .horizontal) {
            $0.distribution = .fillProportionally
            $0.spacing = 12
        }

        let httpMethodView = PFQueryView.makeMethodView(config.httpMethod)
        let endpointLabel = UILabel()
        endpointLabel.text = config.pathTemplate

        view.addSubview(descriptionStack)
        descriptionStack.translatesAutoresizingMaskIntoConstraints = false
        descriptionStack.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12).isActive = true
        descriptionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        descriptionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true

        descriptionStack.addArrangedSubview(httpMethodView)
        descriptionStack.addArrangedSubview(endpointLabel)

        let spacerView = UIView()
        spacerView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        spacerView.setContentHuggingPriority(.defaultLow, for: .vertical)
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spacerView)
        spacerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        spacerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        spacerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true

        vStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStack)
        vStack.topAnchor.constraint(equalTo: descriptionStack.bottomAnchor, constant: 12).isActive = true
        vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        vStack.bottomAnchor.constraint(equalTo: spacerView.topAnchor, constant: 0).isActive = true

        fillVStack()
    }

    private func setupCloseKeyboardGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToCloseKeyboardTriggered))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func tapToCloseKeyboardTriggered() {
        view.endEditing(true)
    }

    override public func viewWillDisappear(_ animated: Bool) {
        guard let config = config else { return }
        vStack.arrangedSubviews.forEach { subview in
            if let editorView = subview as? PFQueryEditorField,
               let value = editorView.value {
                Pathfinder.shared.setParamValue(of: editorView.paramName, value: value, for: config.id)
            }
        }
        onClose?()
        super.viewWillDisappear(animated)
    }

    private func fillVStack() {
        guard let config = config else { return }
        vStack.arrangedSubviews.forEach { subview in
            vStack.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }

        let params = Pathfinder.shared.getCurrentEnvironment().queryParams
        params.forEach { param in
            let value: String? = Pathfinder.shared.getParamValue(of: param, for: config.id)
            let editorField = PFQueryEditorField(paramName: param, value: value)
            vStack.addArrangedSubview(editorField)
        }
    }
}
