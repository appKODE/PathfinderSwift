import UIKit
import Pathfinder_Swift

class ViewController: UIViewController {

    @IBOutlet weak var openPathfinderButton: UIButton!
    @IBOutlet weak var resolveUrlButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()

        // Setup delegate to self
        // For state change handling

        Pathfinder.shared.delegate = self
    }

    // You may set any trigger to open Pathfinder deck
    // For example on device shake or multiple taps

    @IBAction func openPathfinderTapped(_ sender: UIButton) {
        present(Pathfinder.shared.makeController(), animated: true)
    }

    // Call buildUrl() when you need to send your request,
    // Pathfinder will provide the correct URL string
    // taking into consideration environment, path params and query params.

    @IBAction func resolveAuthUrlTapped(_ sender: UIButton) {
        if let url = try? Pathfinder.shared.buildUrl(id: "auth", pathParameters: [:], queryParameters: [:]) {
            print("Resolved Url is: \(url)\n")
        } else {
            print("Pathfinder failed to resolve URL\n")
        }
    }
}

// MARK: - Pathfinder Delegate
extension ViewController: PathfinderStateDelegate {
    func pathfinder(didReceiveUpdatedState state: PFState) {
        print("Pathfinder State received!")
        print("Current environment base url is: \(String(describing: state.currentEnvironment?.baseUrl))\n")
    }
}

// MARK: - Layout
extension ViewController {
    private func configureButtons() {
        openPathfinderButton.layer.cornerRadius = 8
        openPathfinderButton.contentEdgeInsets = .init(
            top: 10, left: 10, bottom: 10, right: 10
        )

        resolveUrlButton.layer.cornerRadius = 8
        resolveUrlButton.contentEdgeInsets = .init(
            top: 10, left: 10, bottom: 10, right: 10
        )
    }
}
