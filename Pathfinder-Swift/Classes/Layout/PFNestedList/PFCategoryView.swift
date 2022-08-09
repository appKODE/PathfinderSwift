import UIKit

final class PFCategoryView: UIView {
    // Handlers
    var onSelectQuery: PFNestedListView.QuerySelectionHandler?

    // Properties
    private var groupTitle: String = ""
    private var queryGroupConfig: [UrlSpec] = []
    private var isExtended: Bool = false {
        didSet {
            isExtended ? fillQueriesStackView() : clearQueriesStackView()
        }
    }

    // Layout
    private var categoryView = UIView()
    private let queriesStackView = UIStackView(axis: .vertical) {
        $0.distribution = .fillProportionally
    }

    convenience init(groupTitle: String, models: [UrlSpec]) {
        self.init()
        self.groupTitle = groupTitle
        queryGroupConfig = models
        setupCategoryView()
        setupViews()
    }

    private func setupViews() {
        addSubview(categoryView)
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        categoryView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        categoryView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        categoryView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        addSubview(queriesStackView)
        queriesStackView.translatesAutoresizingMaskIntoConstraints = false
        queriesStackView.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: 4).isActive = true
        queriesStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        queriesStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        queriesStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    private func setupCategoryView() {
        categoryView.backgroundColor = .lightGray
        categoryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleIsExtended)))

        let containerStackView = UIStackView(axis: .horizontal) {
            $0.spacing = 12
            $0.distribution = .fillProportionally
        }

        let folderImageView = UIImageView()
        folderImageView.image = nil
        folderImageView.height(32)
        folderImageView.width(32)

        let titleLabel = UILabel()
        titleLabel.text = groupTitle
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)

        containerStackView.addArrangedSubviews(titleLabel)
        containerStackView.embedIn(categoryView, hInset: 24, vInset: 12)
    }

    private func fillQueriesStackView() {
        frame = CGRect(
            x: frame.minX,
            y: frame.minY,
            width: frame.width,
            height: frame.height + (56 * CGFloat(queryGroupConfig.count))
        )

        queryGroupConfig.enumerated().forEach { index, query in
            let queryView = PFQueryView(config: query, isLast: (index + 1) == queryGroupConfig.count)
            queryView.onTap = { [weak self] query in
                self?.onSelectQuery?(query)
            }
            queriesStackView.addArrangedSubview(queryView)
        }
    }

    private func clearQueriesStackView() {
        frame = CGRect(
            x: frame.minX,
            y: frame.minY,
            width: frame.width,
            height: frame.height - (56 * CGFloat(queryGroupConfig.count))
        )

        queriesStackView.arrangedSubviews.forEach { subview in
            queriesStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }

    @objc private func toggleIsExtended() {
        self.isExtended.toggle()
    }
}
