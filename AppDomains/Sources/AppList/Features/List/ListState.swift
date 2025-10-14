import Foundation
import AppCore
import AppGroup

public enum ListIntent: Equatable {
    case initialSearch
    case updateSearchText(String)
    case submitSearch
    case newItemAppeared(Int)
    case loadNextPage
}

public struct ListState: Equatable {
    let query: String
    let listingItems: [DSListCellItem]
    let listingState: ListingLoadState
}

extension ListState {
    
    func withNewQuery(_ query: String) -> Self {
        .init(query: query, listingItems: [], listingState: .idle)
    }
    
    func withUpdatedListing(_ listingItems: [DSListCellItem]) -> Self {
        .init(query: query, listingItems: listingItems, listingState: .current)
    }
    
    func withLoadingPage() -> Self {
        .init(query: query, listingItems: listingItems, listingState: .loading)
    }
    
    func withErrorPage(_ errorState: ErrorState) -> Self {
        .init(query: query, listingItems: listingItems, listingState: .failed(errorState))
    }
}
