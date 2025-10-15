import Foundation

struct CatalogResponse: Codable, Sendable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

