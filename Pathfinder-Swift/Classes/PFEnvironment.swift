import Foundation

///
/// Pathfinder environment model
/// Needed to resolve urls with different env. query parameters and base urls
///
public struct PFEnvironment: Equatable {
    
    /// Unique environment identifier
    public let id: UUID

    /// Environment name (e.g.: "DEV", "INT", "RELEASE")
    public let name: String

    /// Base url for environment - root server address
    public let baseUrl: String

    /// Query parameter names, special for current environment (e.g.: "__code" for status code)
    public let queryParams: Set<String>

    public init(
        id: UUID,
        name: String,
        baseUrl: String,
        queryParams: Set<String>
    ) {
        self.id = id
        self.name = name
        self.baseUrl = baseUrl
        self.queryParams = queryParams
    }

    public static func == (lhs: PFEnvironment, rhs: PFEnvironment) -> Bool {
        return lhs.id == rhs.id
    }
}
