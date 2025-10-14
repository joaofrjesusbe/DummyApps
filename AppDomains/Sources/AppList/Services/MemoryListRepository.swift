import SwiftUI
import AppGroup

public final class MemoryListRepository: ListProvidable {
    public private(set) var query: String?
    public private(set) var currentListing = ProductListing()
    
    @Injected(\.imagePageService) private var service
    @Injected(\.logger) private var logger
    
    private let minimumOffsetToLoadNextPage: Int
    private var pendingRequest: Task<ProductListing.Page, Error>?
    
    public init(
        query: String? = nil,
        minimumOffsetToLoadNextPage: Int
    ) {
        self.query = query
        self.minimumOffsetToLoadNextPage = minimumOffsetToLoadNextPage
    }
    
    public func reset(newQuery: String?) {
        pendingRequest?.cancel()
        pendingRequest = nil
        if let newQuery = newQuery {
            self.query = newQuery
            logger.info("New query: \(newQuery)")
        }
        
        currentListing = ProductListing()
    }
    
    public func loadNextPage() async throws {
        defer {
            pendingRequest = nil
        }

        guard pendingRequest == nil else {
            return
        }
        
        let nextPage = currentListing.nextPage
        pendingRequest = getTask(nextPage: nextPage)

        guard let pageInfo = try await pendingRequest?.value else {
            throw NetworkError.general
        }

        currentListing = currentListing.appendPage(pageInfo)
    }

    public func shouldLoadNextPage(index: Int) -> Bool {
        guard index >= currentListing.items.count - minimumOffsetToLoadNextPage else {
            return false
        }

        guard pendingRequest == nil, currentListing.hasNextPage else {
            return false
        }

        return true
    }
        
    private func getTask(nextPage: Int) -> Task<ProductListing.Page, Error> {
        let service = service
        let query = query
        return Task {
            try await service.requestPage(query: query, pageNumber: nextPage)
        }
    }
}

extension MemoryListRepository {
    static var mock: MemoryListRepository {
        let _ = Container.shared.imagePageService.register { MockImagePageService() }
        let provider = MemoryListRepository(minimumOffsetToLoadNextPage: 5)
        return provider
    }
}
