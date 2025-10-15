import SwiftUI

public struct DiscountBadge: View {
    let discount: Double
    
    public init(discount: Double) {
        self.discount = discount
    }
    
    public var body: some View {
        Text(String(format: "-%.0f%%", discount))
            .font(.subheadline.bold())
            .padding(.horizontal, 8).padding(.vertical, 4)
            .background(Color.red.opacity(0.15))
            .foregroundStyle(.red)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .accessibilityLabel(Text("Discount \(Int(discount)) percent"))
    }
}

#Preview {
    DiscountBadge(discount: 3.0)
}
