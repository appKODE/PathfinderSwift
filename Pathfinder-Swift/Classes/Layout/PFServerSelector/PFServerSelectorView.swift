import UIKit

final class PFServerSelectorView: UIView {
    // Handlers
    var onSelected: PFServerTypeView.EnvironmentTypeSelectionHandler?

    // Properties
    private var selectedServerType: PFEnvironment = Pathfinder.shared.getCurrentEnvironment()

    // Layout
    private var mainStackView = UIStackView(axis: .horizontal) {
        $0.distribution = .fillEqually
    }

    init() {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        mainStackView.embedIn(self)
        Pathfinder.shared.getAllEnvironments().forEach { environment in
            let serverTypeView = PFServerTypeView(as: environment, isSelected: environment == selectedServerType)

            serverTypeView.onSelected = { [weak self] environment in
                self?.setSelection(environment)
                self?.onSelected?(environment)
            }

            mainStackView.addArrangedSubview(serverTypeView)
        }
    }

    private func setSelection(_ type: PFEnvironment) {
        mainStackView.arrangedSubviews.forEach { subview in
            if let subview = subview as? PFServerTypeView {
                subview.setSelection(subview.envType == type)
            }
        }
    }
}
