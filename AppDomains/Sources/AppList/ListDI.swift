import Foundation
import AppGroup

@MainActor
public struct ListDI {
    
    static func getListViewModel() -> ProductListViewModel {
        let provider = Container.shared.listProvider
        return ProductListViewModel(provider: provider)
    }
    
    static func setAsMock() {
        let _ = Container.shared.productsService.register { MockProductsService() }
    }
}

extension Container {
    
    @MainActor
    var listProvider: ProductsListProvidable {
        self { @MainActor in
            ProductsRepository(api: self.productsService.resolve())
        }.singleton()
    }
    
    @MainActor
    var productsService: Factory<ProductsService> {
        self { NetworkProductsService() }
    }
    
    @MainActor
    var productUIAdapter: Factory<ProductUIAdaptable> {
        self { @MainActor in ProductUIAdapter() }
    }
}
