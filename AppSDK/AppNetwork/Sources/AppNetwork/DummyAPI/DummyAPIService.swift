import Foundation
import AppCore

public final class DummyAPIService: ProductsService, @unchecked Sendable {
    @Injected(\.httpClient) var httpClient
    
    public init() {}
    
    public func allProducts() async throws -> CatalogResponse {
        let request = Endpoints.allProducts()
        let response = try await httpClient.send(request, decode: CatalogResponse.self)
        return response.value
    }
    
    public func pageProducts(limit: Int, skip: Int) async throws -> CatalogResponse {
        let request = Endpoints.pageProduct(limit: limit, skip: skip)
        let response = try await httpClient.send(request, decode: CatalogResponse.self)
        return response.value
    }
}
