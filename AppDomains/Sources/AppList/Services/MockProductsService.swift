import Foundation

struct MockProductsService: ProductsService {
    func allProducts() async throws -> CatalogResponse {
        enum MockError: Error { case missingCassette, unreadableCassette }
        guard let url = Bundle.module.url(forResource: "Records/GET_products/response", withExtension: "json") else {
            throw MockError.missingCassette
        }
        let data: Data
        do { data = try Data(contentsOf: url) } catch { throw MockError.unreadableCassette }
        let decoder = JSONDecoder.iso8601WithFractionalSeconds
        return try decoder.decode(CatalogResponse.self, from: data)
    }

    func pageProducts(limit: Int, skip: Int) async throws -> CatalogResponse {
        try await allProducts()
    }
}

