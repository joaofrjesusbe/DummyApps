import Foundation

enum Endpoints {
    
    static func allProducts() -> HttpRequest {
        return HttpRequest(
            method: .GET,
            path: "/products",
            queryItems: [
                URLQueryItem(name: "limit", value: 0.description)
            ],
            decoder: JSONDecoder.iso8601WithFractionalSeconds
        )
    }
    
    static let defaultPageSize: Int = 30
}
