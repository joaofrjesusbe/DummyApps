import SwiftUI

public struct InventoryRow: View {
    let rating: Double
    let stock: Int
    
    public init(rating: Double, stock: Int) {
        self.rating = rating
        self.stock = stock
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            RatingView(rating: rating)
            Label("Stock \(stock)", systemImage: "shippingbox")
        }.foregroundStyle(.secondary)
    }
}

#Preview {
    InventoryRow(rating: 3.2, stock: 9)
}
