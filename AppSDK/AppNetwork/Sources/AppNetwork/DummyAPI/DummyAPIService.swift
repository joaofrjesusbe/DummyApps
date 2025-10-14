import Foundation
import AppCore

public final class DummyAPIService {
    @Injected(\.httpClient) var httpClient
    
    public init() {}
    
    public func allProducts() async throws -> CatalogResponse {
        let request = Endpoints.allProducts()
        
        let response = try await httpClient.send(request, decode: CatalogResponse.self)
        return response.value
    }
}
