import SwiftUI

public struct PriceBadge: View {
    let price: Double
    
    public init(price: Double) {
        self.price = price
    }
    
    public var body: some View {
        Text(String(format: "€%.2f", price))
            .font(.headline)
            .padding(.horizontal, 10).padding(.vertical, 6)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    PriceBadge(price: 3.0)
}
