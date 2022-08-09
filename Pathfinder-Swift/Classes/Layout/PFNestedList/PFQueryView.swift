import UIKit

final class PFQueryView: UIView {

    // Handlers
    var onTap: PFNestedListView.QuerySelectionHandler?

    // Properties
    private var config: UrlSpec?

    // Lifecycle
    convenience init(config: UrlSpec, isLast: Bool) {
        self.init()
        self.config = config
        setupViews(isLast: isLast)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(handleTap)))
    }

    // Methods
    private func setupViews(isLast: Bool) {
        guard let config = config else { return }

        let queryView = UIView {
            $0.backgroundColor = .white
        }

        let contentStackView = UIStackView(axis: .horizontal) {
            $0.spacing = 12
            $0.distribution = .fillProportionally
        }

        let containerStackView = UIStackView(axis: .vertical)

        let methodView = Self.makeMethodView(config.httpMethod)

        let titleLabel = UILabel()
        titleLabel.text = config.pathTemplate
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)

        contentStackView.addArrangedSubviews(methodView, titleLabel)
        containerStackView.addArrangedSubview(queryView)
        contentStackView.embedIn(queryView, top: 8, bottom: 8, left: 24, right: 8)

        containerStackView.embedIn(self)
    }

    @objc private func handleTap() {
        guard let configModel = config else { return }
        onTap?(configModel)
    }

    static func makeMethodView(_ method: PFHttpMethod) -> UIView {
        let methodView = UIView()
        let methodLabelView = UILabel()
        methodLabelView.text = method.rawValue.uppercased()
        methodLabelView.textAlignment = .center
        methodLabelView.textColor = .red
        methodLabelView.font = UIFont.boldSystemFont(ofSize: 12)
        methodLabelView.embedIn(methodView)
        methodView.layer.borderWidth = 2
        methodView.layer.borderColor = UIColor.red.cgColor
        methodView.layer.cornerRadius = 6
        methodView.width(60)
        return methodView
    }
}
