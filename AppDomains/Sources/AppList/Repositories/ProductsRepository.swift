import Foundation

@MainActor
struct ProductsRepository: ProductsListProvidable {
    private var api: ProductsService
    let cache: ProductsCache
    
    public init(api: ProductsService, cache: ProductsCache = ProductsCache()) {
        self.api = api
        self.cache = cache
    }
    
    let pageSize = 100

    func bootstrap() async throws -> [Product] {
        // Attempt to load cache; if empty or incomplete, resume fetching
        let cached = await cache.load()
        var index = await cache.loadIndex()

        if let total = index.totalExpected, !cached.isEmpty {
            if index.lastFetchedCount >= total { return cached }
            if cached.count >= total { return cached }
        }

        var products = cached
        var skip = products.count
        let api = self.api
        while true {
            let currentSkip = skip
            let resp: CatalogResponse = try await api.pageProducts(limit: pageSize, skip: currentSkip)
            // Update totalExpected from first response
            if index.totalExpected == nil {
                index.totalExpected = resp.total
            }
            products.append(contentsOf: resp.products)
            index.lastFetchedCount = products.count
            try await cache.save(products)
            try await cache.saveIndex(index)

            skip = products.count
            if products.count >= resp.total { break }
        }
        return products
    }

    func refreshFromNetworkIfNeeded() async throws -> [Product] {
        try await bootstrap()
    }

    func getCached() async -> [Product] {
        await cache.load()
    }
}
