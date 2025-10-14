import Foundation

// MARK: - Top-level response
public struct CatalogResponse: Codable, Sendable {
    public let products: [Product]
    public let total: Int
    public let skip: Int
    public let limit: Int

    public init(products: [Product], total: Int, skip: Int, limit: Int) {
        self.products = products
        self.total = total
        self.skip = skip
        self.limit = limit
    }
}
