import SwiftUI
import AppGroup

@MainActor
protocol ProductUIAdaptable {
    
    func toCellItem(product: Product) -> ListCellItem
}

extension ProductUIAdaptable {
    
    func toArrayCellItems(array: [Product]) -> [ListCellItem] {
        array.map(toCellItem(product:))
    }
}

struct ProductUIAdapter: ProductUIAdaptable {
    
    func toCellItem(product: Product) -> ListCellItem {
        
        return ListCellItem(
            id: product.id,
            title: product.title,
            description: product.description,
            rating: product.rating,
            icon: product.thumbnail
        )
    }
}
