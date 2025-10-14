import SwiftUI
import AppGroup

public typealias ProductListing = Listing<Product, Void>

@MainActor
public protocol ListProvidable {
    var query: String? { get }
    var currentListing: ProductListing { get }
    
    func reset(newQuery: String?)
    func loadNextPage() async throws
    func shouldLoadNextPage(index: Int) -> Bool
}
