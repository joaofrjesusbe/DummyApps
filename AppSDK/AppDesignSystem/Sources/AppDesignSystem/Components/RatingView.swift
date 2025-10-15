import SwiftUI

public struct RatingView: View {
    let rating: Double
    
    public init(rating: Double) {
        self.rating = rating
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            icon
            Text(
                String(format: "%.1f", rating)
            )
            .font(.caption)
            .foregroundStyle(.secondary)
        }        
    }
    
    private var icon: some View {
        Image(systemName: symbol)
            .imageScale(.medium)
            .foregroundStyle(.secondary)
            .accessibilityLabel(Text("Rating: \(String(format: "%.1f", rating))"))
    }
    
    private var symbol: String {
        if rating < 3 {
            return "hand.thumbsdown"
        }
        else if rating <= 4 {
            return "hand.thumbsup"
        }
        else {
            return "star.fill"
        }
    }
}

#Preview {
    RatingView(rating: 1)
}

