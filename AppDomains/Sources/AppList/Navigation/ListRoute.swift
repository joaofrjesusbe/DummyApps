import AppGroup

public enum ListRoute: Routable {
    case detail(_ index: Int)
    
    public var debugDescription: String {
        switch self {
        case .detail(let value):
            return "ListRoute.detail(\(value))"
        }
    }
}
