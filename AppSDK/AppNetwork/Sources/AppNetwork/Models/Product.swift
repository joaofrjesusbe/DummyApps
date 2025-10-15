import Foundation

public struct Product: Identifiable, Codable, Hashable, Sendable {
    public let id: Int
    public let title: String
    public let description: String
    public let price: Double
    public let discountPercentage: Double
    public let rating: Double
    public let stock: Int
    public let brand: String?
    public let category: String
    public let thumbnail: URL
    public let images: [URL]
    
    public init(
        id: Int,
        title: String,
        description: String,
        price: Double,
        discountPercentage: Double,
        rating: Double,
        stock: Int,
        brand: String?,
        category: String,
        thumbnail: URL,
        images: [URL]
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.stock = stock
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
        self.images = images
    }
}

