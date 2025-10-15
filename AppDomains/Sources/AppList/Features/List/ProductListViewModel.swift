import Foundation
import Combine
import AppGroup

@MainActor
final class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var filtered: [Product] = []
    @Published var query: String = "" {
        didSet { applyFilter() }
    }
    @Published var isLoading = false
    @Published var error: String?

    private let provider: ProductsListProvidable

    init(provider: ProductsListProvidable) {
        self.provider = provider
    }

    @MainActor
    func load() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let list = try await provider.bootstrap()
            products = list
            applyFilter()
        } catch {
            self.error = error.localizedDescription
        }
    }

    func applyFilter() {
        let safeQuery = query.foldingDiacriticsLowercased.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !safeQuery.isEmpty else {
            filtered = products
            return
        }
        
        let tokens = safeQuery.split(separator: " ").map(String.init)
        filtered = products.filter { product in
            let hay = "\(product.title) \(product.description)".foldingDiacriticsLowercased
            return tokens.allSatisfy { hay.contains($0) }
        }
    }
}
