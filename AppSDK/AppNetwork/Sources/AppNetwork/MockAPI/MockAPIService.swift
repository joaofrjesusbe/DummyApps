import Foundation
import AppCore

public struct MockAPIService: ProductsService {
    public init() {}
    
    public func allProducts() async throws -> CatalogResponse {
        // TODO: Remake this to make cassete worthy
        
        // Load the catalog cassette from this module's bundle and decode
        enum MockAPIServiceError: Error { case missingCassette, unreadableCassette }
        // Locate the cassette JSON in the current module bundle
        guard let url = Bundle.module.url(forResource: "Records/GET_products/response", withExtension: "json") else {
            throw MockAPIServiceError.missingCassette
        }
        // Load raw data
        let data: Data
        do {
            data = try Data(contentsOf: url)
        } catch {
            throw MockAPIServiceError.unreadableCassette
        }
        // Decode into the expected response model
        let decoder = JSONDecoder.iso8601WithFractionalSeconds
        return try decoder.decode(CatalogResponse.self, from: data)
    }
    
    public func pageProducts(limit: Int, skip: Int) async throws -> CatalogResponse {
        try await allProducts()
    }
}
