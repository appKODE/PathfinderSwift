import Foundation
import UIKit

final class PFNestedListView: UIView {
    typealias QuerySelectionHandler = (UrlSpec) -> Void

    // Handlers
    var onSelectQuery: QuerySelectionHandler?

    // Properties
    private var config: [String: [UrlSpec]] = [:]

    // Layout
    private var scrollView = UIScrollView()
    private var mainVStack = UIStackView(axis: .vertical)

    convenience init(_ config: [String: [UrlSpec]]) {
        self.init()
        self.config = config
        setupViews()
    }

    private func setupViews() {
        scrollView.embedIn(self)
        mainVStack.embedIn(scrollView)
        mainVStack.width(UIScreen.main.bounds.size.width)

        config.forEach { queryGroup in
            let categoryView = PFCategoryView(groupTitle: queryGroup.key, models: queryGroup.value)
            categoryView.onSelectQuery = { [weak self] queryModel in
                self?.onSelectQuery?(queryModel)
            }
            mainVStack.addArrangedSubview(categoryView)
        }
    }
}
