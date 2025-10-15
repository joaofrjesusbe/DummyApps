import Foundation
import AppGroup

@MainActor
public struct ListDI {
    
    static func getListViewModel() -> ProductListViewModel {
        let provider = Container.shared.listProvider
        return ProductListViewModel(provider: provider)
    }
    
    static func setAsMock() {
        let _ = Container.shared.productService.register { MockAPIService() }
    }
}

extension Container {
    
    @MainActor
    var listProvider: ProductsListProvidable {
        self { @MainActor in
            ProductsRepository(api: self.productService.resolve())
        }.singleton()
    }
    
    @MainActor
    var productService: Factory<ProductsService> {
        self { DummyAPIService() }
    }
    
    @MainActor
    var productUIAdapter: Factory<ProductUIAdaptable> {
        self { @MainActor in ProductUIAdapter() }
    }
}
