import Testing
import Foundation
@testable import AppList
import AppGroup

@MainActor
struct ProductListViewModelTests {
    
    struct FakeProvider: ProductsListProvidable {
        let result: Result<[Product], Error>
        func bootstrap() async throws -> [Product] { try result.get() }
        func refreshFromNetworkIfNeeded() async throws -> [Product] { try result.get() }
        func getCached() async -> [Product] { (try? result.get()) ?? [] }
    }
    
    func makeProduct(id: Int, title: String, desc: String) -> Product {
        Product(
            id: id,
            title: title,
            description: desc,
            price: 1,
            discountPercentage: 0,
            rating: 0,
            stock: 0,
            brand: nil,
            category: "test",
            thumbnail: URL(string: "https://example.com/\(id).png")!,
            images: []
        )
    }
    
    @Test
    func load_success_sets_products_and_filtered() async {
        let items = [
            makeProduct(id: 1, title: "Café Premium", desc: "Torrado especial"),
            makeProduct(id: 2, title: "Cafe Solúvel", desc: "Instantâneo")
        ]
        let vm = ProductListViewModel(provider: FakeProvider(result: .success(items)))
        await vm.load()
        #expect(vm.products.count == 2)
        #expect(vm.filtered.count == 2)
        #expect(vm.error == nil)
    }
    
    enum SampleErr: Error { case boom }
    
    @Test
    func load_failure_sets_error_and_stops_loading() async {
        let vm = ProductListViewModel(provider: FakeProvider(result: .failure(SampleErr.boom)))
        await vm.load()
        #expect(vm.products.isEmpty)
        #expect(vm.filtered.isEmpty)
        #expect(vm.error != nil)
        #expect(vm.isLoading == false)
    }
    
    @Test
    func filter_matches_tokens_and_ignores_diacritics() async {
        let items = [
            makeProduct(id: 1, title: "Água Mineral", desc: "Garrafa 1L"),
            makeProduct(id: 2, title: "Sumo de Laranja", desc: "Bebida natural")
        ]
        let vm = ProductListViewModel(provider: FakeProvider(result: .success(items)))
        await vm.load()
        #expect(vm.filtered.count == 2)
        
        vm.query = "agua 1l" // matches both title (diacritic fold) and description token
        #expect(vm.filtered.map { $0.id } == [1])
        
        vm.query = "bebida laranja"
        #expect(vm.filtered.map { $0.id } == [2])
        
        vm.query = "" // reset
        #expect(vm.filtered.count == 2)
    }
}
