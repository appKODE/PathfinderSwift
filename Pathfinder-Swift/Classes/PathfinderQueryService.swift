import Foundation

///
/// QueryService - saves and stores all UrlSpecs,
/// environments and configuration during app live sessions
///
final class PFQueryService {

    /// All pre-configured UrlSpecs (API methods) stored
    var queriesContext: [UrlSpec] = []

    /// All pre-configured environments
    var environmentsContext: [PFEnvironment] = []

    /// Currently chosen environment
    var currentEnvironment: PFEnvironment?
}
