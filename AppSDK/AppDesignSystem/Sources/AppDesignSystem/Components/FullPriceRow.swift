import SwiftUI

public struct FullPriceRow: View {
    let price: Double
    let discountPercentage: Double
    
    public init(price: Double, discountPercentage: Double) {
        self.price = price
        self.discountPercentage = discountPercentage
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            PriceBadge(price: price)
            if discountPercentage > 0 {
                DiscountBadge(discount: discountPercentage)
            }
        }
    }
}

#Preview {
    FullPriceRow(price: 3.0, discountPercentage: 3.0)
}
