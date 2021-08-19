enum PFQueriesPresentationStyle: CaseIterable {
    case list
    case nestedList

    var title: String {
        switch self {
        case .list:
            return "List"
        case .nestedList:
            return "Nested List"
        }
    }

    var iconSystemName: String {
        switch self {
        case .list:
            return "list.bullet"
        case .nestedList:
            return "list.bullet.indent"
        }
    }
}
