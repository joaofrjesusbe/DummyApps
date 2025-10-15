import SwiftUI
import AppGroup

struct ProductListView: View {
    @StateObject var viewModel: ProductListViewModel
    @Environment(\.listNavigate) private var navigate
    @Injected(\.productUIAdapter) private var adapter
    
    var body: some View {
        VStack(spacing: 8) {
            SearchBar(text: $viewModel.query)
            if viewModel.isLoading && viewModel.products.isEmpty {
                ProgressView("Loading…").padding()
            }
            list
                .navigationTitle("Products")
                .alert("Error",
                       isPresented: Binding(get: { viewModel.error != nil },
                                            set: { _ in viewModel.error = nil }
                                           )
                ) {
                    Button("OK", role: .cancel) {
                        
                    }
                } message: {
                    Text(viewModel.error ?? "")
                }
        }
        .task {
            await viewModel.load()
        }
    }
    
    var list: some View {
        List() {
            ForEach(viewModel.filtered, id: \.id) { product in
                ListCell(
                    item: adapter.toCellItem(product: product)) {
                        navigate(.push(.detail(product: product)))
                    }
            }
            
        }
        .listStyle(.plain)
    }
}

#Preview {
    ListDI.setAsMock()
    let viewModel = ListDI.getListViewModel()
    return NavigationStack() {
        ProductListView(viewModel: viewModel)
    }
}
