import Foundation

///
/// Pathfinder configuration model
///
public struct PathfinderConfig {

    /// Initial environment that will be chosen on app start
    public let initialEnvironment: PathfinderEnvironment
    // TODO: - Add diff checker?

    public init(env: PathfinderEnvironment) {
        self.initialEnvironment = env
    }
}
