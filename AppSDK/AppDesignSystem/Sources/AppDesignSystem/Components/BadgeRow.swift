import SwiftUI

public struct BadgeRow: View {
    let price: Double
    let discountPercentage: Double
    
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
    BadgeRow(price: 3.0, discountPercentage: 3.0)
}
