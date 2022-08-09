///
/// Retrievable Pathfinder state
///
public struct PFState {
    /// models for every URL you have in your API
    public let specs: [UrlSpec]

    /// set of different environments that support your API
    public let environments: [PFEnvironment]

    /// Initial environment that will be chosen on app start
    public let currentEnvironment: PFEnvironment?

    public init(specs: [UrlSpec], environments: [PFEnvironment], currentEnvironment: PFEnvironment?) {
        self.specs = specs
        self.environments = environments
        self.currentEnvironment = currentEnvironment
    }
}
