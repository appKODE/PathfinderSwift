import Foundation

public struct UrlSpec: Equatable {
    /// Unique API method identifier
    public let id: String

    /// API end point
    public var pathTemplate: String

    /// HTTP method for future request
    public var httpMethod: PFHttpMethod

    /// Tag - grouping identifier for comfortable layout
    public var tag: String

    /// API method display name
    public var name: String

    /// Temporary envParams, depends on currently chosen environment
    public var temporaryEnvParameters: [String: String] = [:]
    // TODO: - Create separate storage for environment parameters for every UrlSpec

    public init(
        id: String,
        pathTemplate: String,
        httpMethod: PFHttpMethod,
        tag: String,
        name: String,
        currentStoplightQueryParams: [String: String]
    ) {
        self.id = id
        self.pathTemplate = pathTemplate
        self.httpMethod = httpMethod
        self.tag = tag
        self.name = name
        self.temporaryEnvParameters = currentStoplightQueryParams
    }

    public static func == (lhs: UrlSpec, rhs: UrlSpec) -> Bool {
        return lhs.id == rhs.id
    }
}
