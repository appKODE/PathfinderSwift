import Foundation
import UIKit

final class PathfinderPresentationStyleSelectorView: UIView {
    private enum Constant {
        static let defaultPresentationStyle: PathfinderQueriesPresentationStyle = .list
    }

    // Handlers
    var onSelect: PathfinderPresentationStyleView.PresentationStyleTappedHandler?

    // Properties
    private var presentationStyle: PathfinderQueriesPresentationStyle = .list

    // Layout
    private var selectorStack = UIStackView(axis: .horizontal) {
        $0.distribution = .fillEqually
    }

    convenience init(_ style: PathfinderQueriesPresentationStyle) {
        self.init()
        presentationStyle = style
        setupViews()
    }

    private func setupViews() {
        selectorStack.embedIn(self)
        PathfinderQueriesPresentationStyle.allCases.forEach { style in
            let styleView = PathfinderPresentationStyleView(
                as: style,
                isSelected: style == Constant.defaultPresentationStyle ? true : false
            )
            styleView.onStyleSelected = { [weak self] style in
                self?.setSelection(style)
                self?.onSelect?(style)
            }
            selectorStack.addArrangedSubview(styleView)
        }
    }

    private func setSelection(_ style: PathfinderQueriesPresentationStyle) {
        selectorStack.arrangedSubviews.forEach { styleView in
            if let styleView = styleView as? PathfinderPresentationStyleView {
                styleView.setSelection(styleView.presentationStyle == style)
            }
        }
    }
}
