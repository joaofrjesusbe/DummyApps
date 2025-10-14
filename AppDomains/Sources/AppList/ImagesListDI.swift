import Foundation
import AppGroup

@MainActor
public struct ListDI {
    
    static func getListViewModel() -> ListViewModel {
        let provider = Container.shared.listProvider
        return ListViewModel(provider: provider)
    }
}

extension Container {
    
    @MainActor
    var listProvider: ListProvidable {
        self { @MainActor in
            MemoryListRepository(query: nil, minimumOffsetToLoadNextPage: 5)
        }.singleton()
    }
    
    var productService: Factory<ImagePageService> {
        self { PixabayAPIService() }
    }
    
    @MainActor
    var imageInfoUIAdapter: Factory<ImageInfoUIAdaptable> {
        self { @MainActor in ImageInfoUIAdapter() }
    }
}
