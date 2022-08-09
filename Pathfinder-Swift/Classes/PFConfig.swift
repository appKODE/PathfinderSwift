import Foundation

///
/// Pathfinder configuration model
///
public struct PFConfig {
    /// models for every URL you have in your API
    public let specs: [UrlSpec]

    /// set of different environments that support your API
    public let environments: [PFEnvironment]

    /// Initial environment that will be chosen on app start
    public let initialEnvironment: PFEnvironment
    // TODO: - Add diff checker?

    public init(specs: [UrlSpec], environments: [PFEnvironment], initialEnvironmentIndex: Int) {
        self.specs = specs
        self.environments = environments

        guard environments.indices.contains(initialEnvironmentIndex) else {
            assertionFailure("Pathfinder Error: Configuration error - passed environment index is out of range")
            if let firstEnvironment = environments.first {
                self.initialEnvironment = firstEnvironment
            } else {
                fatalError("Pathfinder Error: Configuration error - no environments found")
            }
            return
        }
        self.initialEnvironment = environments[initialEnvironmentIndex]
    }
}
