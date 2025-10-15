import SwiftUI

public struct ListCell: View, Identifiable {
    public let id: String
    public let item: ListCellItem
    public let didSelect: () -> Void
    
    public init(
        item: ListCellItem,
        didSelect: @escaping () -> Void
    ) {
        self.id = item.id
        self.item = item
        self.didSelect = didSelect
    }

    public var body: some View {
        Button(action: {
            didSelect()
        }, label: {
            content
        })
    }

    var content: some View {
        HStack(spacing: 12) {
            RemoteImage(url: item.icon)
                .frame(width: 64, height: 64)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .accessibilityHidden(true)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                    
                Text(item.description)
                    .font(.subheadline)
                    .lineLimit(2)
                    .foregroundColor(.secondary)
                
                RatingView(rating: item.rating)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ListCell(
        item: ListCellItem(
            id: "",
            title: "Title",
            description: "Description",
            rating: 3.0,
            icon: URL(string: "")),
        didSelect: {}
    )
}
