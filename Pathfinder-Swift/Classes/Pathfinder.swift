import UIKit

public protocol PathfinderStateDelegate: AnyObject {
    ///
    /// Method that is fired when any changes
    /// are made in Url Specs configurations
    ///
    /// - Parameters:
    ///   - state - PathfinderState object (current UrlSpecs,
    ///     environments and currently chosen environment)
    ///
    func pathfinder(didReceiveUpdatedState state: PFState)
}

public final class Pathfinder {
    public static let shared = Pathfinder()

    private let queryService = PFQueryService()

    weak public var delegate: PathfinderStateDelegate?

    public init() { }

    ///
    /// Initial configuration of module
    ///
    /// - Parameters:
    ///   - config: Pathfinder configuration model
    ///     - specs:              models for every URL you have in your API
    ///     - environments:  set of different environments that support your API
    ///     - config:              sets up initial environment on start
    public func configure(config: PFConfig) {
        queryService.queriesContext      = config.specs
        queryService.environmentsContext = config.environments
        queryService.currentEnvironment  = config.initialEnvironment
    }

    ///
    /// Builds **urls** depending on current environment, specialized environment parameters, and passed parameters
    ///
    /// - Throws:
    ///   - PathfinderError.urlNotFound:  if passed UrlSpec id is wrong
    ///
    /// - Parameters:
    ///   - id:              unique UrlSpec identifier
    ///   - pathParameters:  dictionary, which key is path parameter
    ///                      that could be found in endPoint
    ///                      (ex.: {sessionId} in auth/login/{sessionId}).
    ///   - queryParameters: dictionary, which element are added to final URL via "?" or "&"
    ///
    /// - Returns:
    ///   - Resolved string ready to be converted to URL (with pathParams, queryParams, envParams)
    ///
    public func buildUrl(id: String, pathParameters: [String: String], queryParameters: [String: String]) throws -> String {

        guard let specIndex = queryService.queriesContext.firstIndex(where: { $0.id == id }) else {
            throw PFError.urlNotFoundForId
        }

        guard let currentEnvironment = queryService.currentEnvironment else {
            throw PFError.currentEnvironmentIsNotSet
        }

        let urlSpec = queryService.queriesContext[specIndex]
        let baseUrl = currentEnvironment.baseUrl
        var fullUrl = baseUrl + urlSpec.pathTemplate

        pathParameters.forEach { paramName, paramValue in
            fullUrl = fullUrl.replacingOccurrences(of: "{\(paramName)}", with: paramValue)
        }

        queryParameters.enumerated().forEach { index, parameter in
            var additionalString: String = ""
            if index == 0 { additionalString = "?" }
            else { additionalString = "&" }

            fullUrl = fullUrl + additionalString + parameter.key + "=" + parameter.value
        }

        urlSpec.temporaryEnvParameters.enumerated().forEach { index, parameter in
            var additionalString: String = ""
            if fullUrl.contains("?") {
                additionalString = "&"
            } else {
                additionalString = "?"
            }

            fullUrl = fullUrl + additionalString + parameter.key + "=" + parameter.value
        }

        return fullUrl
    }

    ///
    /// Retrieves current Pathfinder environment
    ///
    /// - Returns: Pathfinder configuration model that is currently active
    ///
    public func currentEnvironment() -> PFEnvironment? {
        return queryService.currentEnvironment
    }

    ///
    /// Returns PathfinderController to present
    ///
    public func makeController() -> UIViewController {
        return PFController()
    }

    ///
    /// Sets up temporary value for environment parameter in UrlSpec.temporaryEnvParameters for single UrlSpec
    ///
    /// - Parameters:
    ///   - paramName: key for one of temporaryEnvParameters elements (is got from current environment spec)
    ///   - value:     String value, current temporary environment parameter value
    ///   - urlId:     UrlSpec Id, needed to save envParam value only for one definite UrlSpec
    ///
    public func setParamValue(of paramName: String, value: String, for urlId: String) {
        var allQueries = Self.shared.getAllUrls()

        if let queryIndex = allQueries.firstIndex(where: { $0.id == urlId }) {
            allQueries[queryIndex].temporaryEnvParameters[paramName] = value
            queryService.queriesContext = allQueries
        }

        delegate?.pathfinder(didReceiveUpdatedState: currentState())
    }

    ///
    /// Retrieves current Pathfinder configuration state
    ///
    /// - Returns: Pathfinder configuration model that is currently active
    ///
    func currentState() -> PFState {
        return PFState(
            specs: queryService.queriesContext,
            environments: queryService.environmentsContext,
            currentEnvironment: currentEnvironment()
        )
    }

    ///
    /// Switches current environment to chosen one
    ///
    func changeEnvironment(to environment: PFEnvironment) {
        queryService.currentEnvironment = environment

        for i in 0..<queryService.queriesContext.count {
            queryService.queriesContext[i].temporaryEnvParameters = [:]
        }

        delegate?.pathfinder(didReceiveUpdatedState: currentState())
    }

    ///
    /// Returns all UrlSpec models to display in PathfinderController list
    ///
    func getAllUrls() -> [UrlSpec] {
        return queryService.queriesContext
    }

    ///
    /// Returns all UrlSpecs grouped by .tag value to
    /// display in nested list of PathfinderController
    ///
    func getGroupedRequests() -> [String: [UrlSpec]] {
        return Dictionary(grouping: queryService.queriesContext, by: { $0.tag })
    }

    ///
    /// Returns all pre-configured environments to display in PathfinderController
    ///
    func getAllEnvironments() -> [PFEnvironment] {
        return queryService.environmentsContext
    }

    ///
    /// Returns actual chosen environment
    ///
    /// - Returns: Actual chosen environment, may be changed during session
    ///
    func getCurrentEnvironment() -> PFEnvironment {
        guard let currentEnvironment = queryService.currentEnvironment
        else { fatalError("PathfinderError: Could not get current environment") }

        return currentEnvironment
    }

    ///
    /// Searches for environment parameter in session temporary storage
    ///
    /// - Parameters:
    ///   - paramName: key for one of temporaryEnvParameters elements (is got from current environment spec)
    ///   - urlId:     UrlSpec Id, needed to retrieve envParam value only for one definite UrlSpec
    /// - Returns:
    ///   - Current temporary value for this environment parameter
    ///
    func getParamValue(of paramName: String, for urlId: String) -> String? {
        guard let query = queryService.queriesContext.first(where: { $0.id == urlId})
        else { return nil }

        if let value = query.temporaryEnvParameters[paramName] {
            return value
        } else {
            return nil
        }
    }
}
