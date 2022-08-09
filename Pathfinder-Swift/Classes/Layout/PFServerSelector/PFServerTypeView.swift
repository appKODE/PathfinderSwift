import Foundation
import UIKit

final class PFServerTypeView: UIView {
    typealias EnvironmentTypeSelectionHandler = (PFEnvironment) -> Void

    // Handlers
    var onSelected: EnvironmentTypeSelectionHandler?

    // Properties
    public var envType: PFEnvironment?
    private var isSelected: Bool = false {
        didSet { render() }
    }

    // Layout
    private let titleLabel = UILabel()

    convenience init(as type: PFEnvironment, isSelected: Bool) {
        self.init()
        self.envType = type
        self.isSelected = isSelected
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHandler)))
        setupViews()
        render()
    }

    private func setupViews() {
        titleLabel.text = envType?.name
        titleLabel.placeInCenter(of: self)
        height(56)
    }

    private func render() {
        UIView.animate(withDuration: 0.15) {
            self.backgroundColor = self.isSelected ? .blue : .clear
            self.titleLabel.textColor = self.isSelected ? .white : .black
        }
    }

    @objc private func tapHandler() {
        guard let serverType = envType else { return }
        onSelected?(serverType)
    }

    public func setSelection(_ isSelected: Bool) {
        self.isSelected = isSelected
    }
}
