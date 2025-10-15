import Foundation
import Combine
import AppGroup

@MainActor
final class ProductDetailViewModel: ObservableObject {
    @Published var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var mainURL: URL? {
        if let firstMainImage = product.images.first {
            return firstMainImage
        } else {
            return product.thumbnail
        }
    }
}
