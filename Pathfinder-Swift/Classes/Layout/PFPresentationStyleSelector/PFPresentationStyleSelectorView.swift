import Foundation
import UIKit

final class PFPresentationStyleSelectorView: UIView {
    private enum Constant {
        static let defaultPresentationStyle: PFQueriesPresentationStyle = .list
    }

    // Handlers
    var onSelect: PFPresentationStyleView.PresentationStyleTappedHandler?

    // Properties
    private var presentationStyle: PFQueriesPresentationStyle = .list

    // Layout
    private var selectorStack = UIStackView(axis: .horizontal) {
        $0.distribution = .fillEqually
    }

    convenience init(_ style: PFQueriesPresentationStyle) {
        self.init()
        presentationStyle = style
        setupViews()
    }

    private func setupViews() {
        selectorStack.embedIn(self)
        PFQueriesPresentationStyle.allCases.forEach { style in
            let styleView = PFPresentationStyleView(
                as: style,
                isSelected: style == Constant.defaultPresentationStyle ? true : false
            )
            styleView.onStyleSelected = { [weak self] style in
                self?.onSelect?(style)
            }
            selectorStack.addArrangedSubview(styleView)
        }
    }

    func setSelection(_ style: PFQueriesPresentationStyle) {
        selectorStack.arrangedSubviews.forEach { styleView in
            if let styleView = styleView as? PFPresentationStyleView {
                styleView.setSelection(styleView.presentationStyle == style)
            }
        }
    }
}
