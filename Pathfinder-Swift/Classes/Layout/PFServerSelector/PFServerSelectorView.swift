import UIKit

final class PFServerSelectorView: UIView {
    // Handlers
    var onSelected: PFServerTypeView.EnvironmentTypeSelectionHandler?

    // Properties
    private let pathfinder: Pathfinder

    private lazy var selectedServerType: PFEnvironment = pathfinder.getCurrentEnvironment()

    // Layout
    private var mainStackView = UIStackView(axis: .horizontal) {
        $0.distribution = .fillEqually
    }

    init(pathfinder: Pathfinder) {
        self.pathfinder = pathfinder
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        mainStackView.embedIn(self)
        pathfinder.getAllEnvironments().forEach { environment in
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
