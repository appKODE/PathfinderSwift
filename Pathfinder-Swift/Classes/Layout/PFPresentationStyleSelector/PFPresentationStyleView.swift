import Foundation
import UIKit

final class PFPresentationStyleView: UIView {
    typealias PresentationStyleTappedHandler = (PFQueriesPresentationStyle) -> Void

    // Handlers
    var onStyleSelected: PresentationStyleTappedHandler?

    // Properties
    public var presentationStyle: PFQueriesPresentationStyle?
    private var isSelected: Bool = false {
        didSet { render() }
    }

    // Layout
    private let mainStack = UIStackView(axis: .vertical) {
        $0.spacing = 10
    }
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()
    private let bottomBorder = UIView {
        $0.backgroundColor = .blue
    }

    // Lifecycle
    convenience init(as style: PFQueriesPresentationStyle, isSelected: Bool) {
        self.init()
        self.presentationStyle = style
        self.isSelected = isSelected

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHandler)))
        setupViews()
        render()
    }

    private func setupViews() {
        guard let presentationStyle = presentationStyle else { return }
        titleLabel.text = presentationStyle.title
        titleLabel.textAlignment = .center
        iconImageView.image = nil
        iconImageView.contentMode = .scaleAspectFit
        mainStack.addArrangedSubviews(titleLabel)

        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true

        addSubview(bottomBorder)
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.height(3)
        bottomBorder.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bottomBorder.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomBorder.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 12).isActive = true
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func render() {
        UIView.animate(withDuration: 0.3) {
            self.bottomBorder.alpha = self.isSelected ? 1 : 0
        }
    }

    func setSelection(_ isSelected: Bool) {
        guard isSelected != self.isSelected else { return }
        self.isSelected = isSelected
    }

    @objc private func tapHandler() {
        guard let presentationStyle = presentationStyle else { return }
        onStyleSelected?(presentationStyle)
    }
}
