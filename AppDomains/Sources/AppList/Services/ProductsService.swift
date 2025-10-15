import Foundation

protocol ProductsService: Sendable {
    func allProducts() async throws -> CatalogResponse
    func pageProducts(limit: Int, skip: Int) async throws -> CatalogResponse
}

