import Foundation

public protocol ProductsService {
    
    // TODO:
    // Make pagination and if there is failure save the state so we can retry without asking for everything again
    // But for this timeline will keep it simple due low number of products. This will not scale for huge number of products
    public func allProducts() async throws -> CatalogResponse {
}
