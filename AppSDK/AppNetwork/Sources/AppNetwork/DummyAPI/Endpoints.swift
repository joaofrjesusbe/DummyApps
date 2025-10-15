import Foundation

enum Endpoints {
    
    static func allProducts() -> HttpRequest {
        HttpRequest(
            method: .GET,
            path: "/products",
            queryItems: [
                URLQueryItem(name: "limit", value: 0.description)
            ],
            decoder: JSONDecoder.iso8601WithFractionalSeconds
        )
    }
    
    static func pageProduct(limit: Int, skip: Int) -> HttpRequest {
        HttpRequest(
            method: .GET,
            path: "/products",
            queryItems: [
                URLQueryItem(name: "limit", value: limit.description),
                URLQueryItem(name: "skip", value: limit.description)
            ],
            decoder: JSONDecoder.iso8601WithFractionalSeconds
        )
    }
    
    static let defaultPageSize: Int = 30
}
