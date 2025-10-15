import AppGroup

public enum ListRoute: Routable {
    case detail(product: Product)
    
    public var debugDescription: String {
        switch self {
        case .detail(let value):
            return "ListRoute.detail(\(value))"
        }
    }
}
