import Foundation

///
/// QueryService - saves and stores all UrlSpecs,
/// environments and configuration during app live sessions
///
final class QueryService {

    /// All pre-configured UrlSpecs (API methods) stored
    var queriesContext: [UrlSpec] = []

    /// All pre-configured environments
    var environmentsContext: [PathfinderEnvironment] = []

    /// Currently chosen environment
    var currentEnvironment: PathfinderEnvironment?

    // TODO: - Add DataBase storage later
    /*
    public init() {
        self.retrieve()
    }

    public func retrieve() {
        // TODO: Change to real retrieve from DB
        self.queriesContext = [
            
        ]
    }

    public func save() {
        // Save to database
    }
    */
}
