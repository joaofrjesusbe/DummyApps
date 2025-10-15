import Testing
import Foundation
@testable import AppList
import AppGroup

struct ProductsCacheTests {
    func sampleProducts() -> [Product] {
        [
            Product(id: 1, title: "A", description: "a", price: 1, discountPercentage: 0, rating: 0, stock: 0, brand: nil, category: "c", thumbnail: URL(string: "https://e.com/1.png")!, images: []),
            Product(id: 2, title: "B", description: "b", price: 2, discountPercentage: 0, rating: 0, stock: 0, brand: nil, category: "c", thumbnail: URL(string: "https://e.com/2.png")!, images: [])
        ]
    }

    @Test
    func save_and_load_roundtrip() async {
        let cache = ProductsCache()
        await cache.clear()
        let items = sampleProducts()
        try? await cache.save(items)
        let loaded = await cache.load()
        #expect(loaded == items)
    }

    @Test
    func index_save_and_load_roundtrip() async {
        let cache = ProductsCache()
        await cache.clear()
        let index = CacheIndex(lastFetchedCount: 123, totalExpected: 456)
        try? await cache.saveIndex(index)
        let read = await cache.loadIndex()
        #expect(read.lastFetchedCount == 123)
        #expect(read.totalExpected == 456)
    }

    @Test
    func clear_removes_files() async {
        let cache = ProductsCache()
        let items = sampleProducts()
        try? await cache.save(items)
        try? await cache.saveIndex(CacheIndex(lastFetchedCount: items.count, totalExpected: items.count))
        await cache.clear()
        let loaded = await cache.load()
        let index = await cache.loadIndex()
        #expect(loaded.isEmpty)
        #expect(index.lastFetchedCount == 0)
        #expect(index.totalExpected == nil)
    }
}
