import Foundation
import AppGroup

final class NetworkProductsService: ProductsService, @unchecked Sendable {
    @Injected(\.httpClient) var httpClient

    func allProducts() async throws -> CatalogResponse {
        let request = Endpoints.allProducts()
        let response = try await httpClient.send(request, decode: CatalogResponse.self)
        return response.value
    }

    func pageProducts(limit: Int, skip: Int) async throws -> CatalogResponse {
        let request = Endpoints.pageProduct(limit: limit, skip: skip)
        let response = try await httpClient.send(request, decode: CatalogResponse.self)
        return response.value
    }
}

