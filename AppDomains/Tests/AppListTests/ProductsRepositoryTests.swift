import Testing
import Foundation
@testable import AppList
import AppGroup

@MainActor
struct ProductsRepositoryTests {
    final class FakeProductsService: ProductsService, @unchecked Sendable {
        var allProductsImpl: () async throws -> CatalogResponse = { fatalError("not used") }
        var pageProductsImpl: (Int, Int) async throws -> CatalogResponse
        
        private(set) var pageCalls: [(limit: Int, skip: Int)] = []
        
        init(pageProductsImpl: @escaping (Int, Int) async throws -> CatalogResponse) {
            self.pageProductsImpl = pageProductsImpl
        }
        
        func allProducts() async throws -> CatalogResponse { try await allProductsImpl() }
        func pageProducts(limit: Int, skip: Int) async throws -> CatalogResponse {
            pageCalls.append((limit, skip))
            return try await pageProductsImpl(limit, skip)
        }
    }

    func makeProducts(total: Int) -> [Product] {
        (0..<total).map { i in
            Product(id: i, title: "P\(i)", description: "D\(i)", price: 1, discountPercentage: 0, rating: 0, stock: 0, brand: nil, category: "c", thumbnail: URL(string: "https://e.com/\(i).png")!, images: [])
        }
    }

    func makeTempCache() -> ProductsCache {
        let base = FileManager.default.temporaryDirectory.appendingPathComponent("ProductsCacheTests-\(UUID().uuidString)", isDirectory: true)
        try? FileManager.default.createDirectory(at: base, withIntermediateDirectories: true)
        let fileURL = base.appendingPathComponent("ProductCache.json")
        let indexURL = base.appendingPathComponent("ProductCache.index.json")
        return ProductsCache(fileURL: fileURL, indexURL: indexURL)
    }

    @Test
    func bootstrap_fetches_all_pages_and_caches() async throws {
        let total = 250
        let items = makeProducts(total: total)
        let service = FakeProductsService { limit, skip in
            let slice = Array(items.dropFirst(skip).prefix(limit))
            return CatalogResponse(products: slice, total: total, skip: skip, limit: limit)
        }
        let repo = ProductsRepository(api: service, cache: makeTempCache())

        let list = try await repo.bootstrap()
        #expect(list.count == total)

        // Expect 3 calls for 250 with pageSize 100
        #expect(service.pageCalls.count == 3)

        let cached = await repo.getCached()
        #expect(cached.count == total)

        let index = await repo.cache.loadIndex()
        #expect(index.totalExpected == total)
        #expect(index.lastFetchedCount == total)
    }

    @Test
    func bootstrap_uses_cache_when_complete() async throws {
        let total = 50
        let items = makeProducts(total: total)
        let service = FakeProductsService { limit, skip in
            let slice = Array(items.dropFirst(skip).prefix(limit))
            return CatalogResponse(products: slice, total: total, skip: skip, limit: limit)
        }
        let repo = ProductsRepository(api: service, cache: makeTempCache())

        // Pre-populate cache as complete
        try await repo.cache.save(items)
        try await repo.cache.saveIndex(CacheIndex(lastFetchedCount: total, totalExpected: total))

        let loaded = try await repo.bootstrap()
        #expect(loaded.count == total)
        // Ensure no network calls were needed
        #expect(service.pageCalls.isEmpty)
    }

    @Test
    func bootstrap_resumes_from_partial_cache_then_completes() async throws {
        let total = 250
        let items = makeProducts(total: total)
        let service = FakeProductsService { limit, skip in
            let slice = Array(items.dropFirst(skip).prefix(limit))
            return CatalogResponse(products: slice, total: total, skip: skip, limit: limit)
        }
        let repo = ProductsRepository(api: service, cache: makeTempCache())

        // Prepare partial cache (e.g., 120 of 250)
        let partial = 120
        try await repo.cache.save(Array(items.prefix(partial)))
        try await repo.cache.saveIndex(CacheIndex(lastFetchedCount: partial, totalExpected: total))

        let loaded = try await repo.bootstrap()
        #expect(loaded.count == total)

        // Should fetch remaining pages starting at skip=120, then skip=220
        #expect(service.pageCalls.count == 2)
        #expect(service.pageCalls[0].limit == 100)
        #expect(service.pageCalls[0].skip == 120)
        #expect(service.pageCalls[1].skip == 220)

        let index = await repo.cache.loadIndex()
        #expect(index.totalExpected == total)
        #expect(index.lastFetchedCount == total)
    }
}
