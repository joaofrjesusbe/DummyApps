import Foundation

struct CacheIndex: Codable, Sendable {
    var lastFetchedCount: Int
    var totalExpected: Int?
}

actor ProductsCache {
    private let fileURL: URL
    private let indexURL: URL
    private let fm = FileManager.default

    init(fileURL: URL, indexURL: URL) {
        self.fileURL = fileURL
        self.indexURL = indexURL
    }

    init() {
        let fm = FileManager.default
        
        let cachesRoot = fm.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let cachesDir = cachesRoot.appendingPathComponent("AppList", isDirectory: true)
        try? fm.createDirectory(at: cachesDir, withIntermediateDirectories: true)

        let newFile = cachesDir.appendingPathComponent("ProductCache.json")
        let newIndex = cachesDir.appendingPathComponent("ProductCache.index.json")

        self.fileURL = newFile
        self.indexURL = newIndex
    }

    func load() async -> [Product] {
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([Product].self, from: data)
        } catch {
            return []
        }
    }

    func save(_ products: [Product]) async throws {
        let data = try JSONEncoder().encode(products)
        try data.write(to: fileURL, options: .atomic)
    }

    func loadIndex() async -> CacheIndex {
        do {
            let data = try Data(contentsOf: indexURL)
            let index = try JSONDecoder().decode(CacheIndex.self, from: data)
            return index
        } catch {
            return CacheIndex(lastFetchedCount: 0, totalExpected: nil)
        }
    }

    func saveIndex(_ index: CacheIndex) async throws {
        let data = try JSONEncoder().encode(index)
        try data.write(to: indexURL, options: .atomic)
    }

    func clear() async {
        try? fm.removeItem(at: fileURL)
        try? fm.removeItem(at: indexURL)
    }
}
