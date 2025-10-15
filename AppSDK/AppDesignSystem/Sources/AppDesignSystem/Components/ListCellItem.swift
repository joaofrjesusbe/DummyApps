import SwiftUI

public struct ListCellItem: Identifiable, Equatable {
    public let id: String
    public let title: String
    public let description: String
    public let rating: Double
    public let icon: URL?
    
    public init(
        id: String,
        title: String,
        description: String,
        rating: Double,
        icon: URL?
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.rating = rating
        self.icon = icon
    }
}
