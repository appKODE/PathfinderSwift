import Foundation
import UIKit

final class PFController: UIViewController {
    private enum Constant {
        static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    }

    /// Stack container view
    private let stackView = UIStackView(axis: .vertical) {
        $0.axis = .vertical
    }
    private let topPart = UIView()
    private let bottomPart = UIView()

    private let baseListTable = UITableView()

    private let presentationStyleSelectorView = PFPresentationStyleSelectorView(.list)

    private var presentationPagerContainer = UIStackView()
    private let serverSelector = PFServerSelectorView()
    private var nestedView = PFNestedListView(Pathfinder.shared.getGroupedRequests())
    private var dataList: [UrlSpec] = Pathfinder.shared.getAllUrls()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayout()
        setupTable()
        serverSelector.onSelected = { server in
            Pathfinder.shared.changeEnvironment(to: server)
        }
    }

    private func refreshData() {
        nestedView = PFNestedListView(Pathfinder.shared.getGroupedRequests())
        dataList   = Pathfinder.shared.getAllUrls()

        nestedView.onSelectQuery = { [weak self] query in
            self?.present(PFQueryEditorController(config: query), animated: true)
        }

        handlePresentationStyleChange(to: .list)
        baseListTable.reloadData()
    }

    /// Setting up controller layout
    private func configureLayout() {
        stackView.embedIn(view)

        nestedView.onSelectQuery = { [weak self] query in
            self?.present(PFQueryEditorController(config: query), animated: true)
        }

        presentationStyleSelectorView.onSelect = { [weak self] style in
            self?.handlePresentationStyleChange(to: style)
        }

        stackView.addArrangedSubviews(
            configureTop(),
            configureBottom(),
            serverSelector,
            presentationStyleSelectorView,
            presentationPagerContainer
        )

        presentationPagerContainer.addArrangedSubviews(baseListTable)
    }

    private func setupTable() {
        baseListTable.dataSource = self
        baseListTable.delegate = self
        baseListTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func handlePresentationStyleChange(to style: PFQueriesPresentationStyle) {
        switch style {
        case .list:
            presentationPagerContainer.arrangedSubviews.forEach { subview in
                UIView.animate(withDuration: 0.15, animations: {
                    subview.alpha = 0
                }, completion: { _ in
                    self.presentationPagerContainer.removeArrangedSubview(subview)
                    subview.removeFromSuperview()
                    subview.alpha = 1
                    self.baseListTable.alpha = 0
                    self.presentationPagerContainer.addArrangedSubview(self.baseListTable)
                    UIView.animate(withDuration: 0.3) {
                        self.baseListTable.alpha = 1
                    }
                })
            }

        case .nestedList:
            presentationPagerContainer.arrangedSubviews.forEach { subview in
                UIView.animate(withDuration: 0.15, animations: {
                    subview.alpha = 0
                }, completion: { _ in
                    self.presentationPagerContainer.removeArrangedSubview(subview)
                    subview.removeFromSuperview()
                    subview.alpha = 1
                    self.nestedView.alpha = 0
                    self.presentationPagerContainer.addArrangedSubview(self.nestedView)
                    UIView.animate(withDuration: 0.3) {
                        self.nestedView.alpha = 1
                    }
                })
            }
        }
    }

    /// Configuring search and filter sections
    private func configureTop() -> UIView {
        let container = UIView()
        UISearchBar().embedIn(container, inset: 10)
        return container
    }

    private func configureBottom() -> UIView {
        return UIView {
            $0.backgroundColor = .white
        }
    }
}

// MARK: - UITableView Delegate
extension PFController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataList[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let queryModel = dataList[indexPath.row]
        let controller = PFQueryEditorController(config: queryModel)
        controller.onClose = { [weak self] in
            self?.refreshData()
        }
        present(controller, animated: true)
    }
}
