import SwiftUI
import AppGroup

struct ProductDetailView: View {
    @StateObject var viewModel: ProductDetailViewModel
    
    var body: some View {
        ScrollView {
                        
            CollapsingHeaderImage(url: viewModel.mainURL)
            
            let product = viewModel.product
            VStack(alignment: .leading, spacing: 12) {
                
                Text(product.title).font(.title.bold())
                
                InventoryRow(rating: product.rating, stock: product.stock)
                
                FullPriceRow(price: product.price, discountPercentage: product.discountPercentage)

                Text(viewModel.product.description)
                    .font(.body)
                    .padding(.top, 8)
            }
            .padding()
        }
        //.navigationTitle("Details")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}
