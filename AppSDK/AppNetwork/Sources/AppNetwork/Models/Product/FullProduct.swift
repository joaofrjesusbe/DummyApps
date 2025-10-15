import Foundation

// MARK: - Product
public struct FullProduct: Codable, Identifiable, Hashable, Sendable {
    public let id: Int
    public let title: String
    public let description: String
    public let category: String
    public let price: Double
    public let discountPercentage: Double
    public let rating: Double
    public let stock: Int
    public let tags: [String]
    public let brand: String?
    public let sku: String
    public let weight: Int
    public let dimensions: Dimensions
    public let warrantyInformation: String
    public let shippingInformation: String
    public let availabilityStatus: String
    public let reviews: [Review]
    public let returnPolicy: String
    public let minimumOrderQuantity: Int
    public let meta: Meta
    public let images: [URL]
    public let thumbnail: URL

    public init(
        id: Int,
        title: String,
        description: String,
        category: String,
        price: Double,
        discountPercentage: Double,
        rating: Double,
        stock: Int,
        tags: [String],
        brand: String?,
        sku: String,
        weight: Int,
        dimensions: Dimensions,
        warrantyInformation: String,
        shippingInformation: String,
        availabilityStatus: String,
        reviews: [Review],
        returnPolicy: String,
        minimumOrderQuantity: Int,
        meta: Meta,
        images: [URL],
        thumbnail: URL
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.stock = stock
        self.tags = tags
        self.brand = brand
        self.sku = sku
        self.weight = weight
        self.dimensions = dimensions
        self.warrantyInformation = warrantyInformation
        self.shippingInformation = shippingInformation
        self.availabilityStatus = availabilityStatus
        self.reviews = reviews
        self.returnPolicy = returnPolicy
        self.minimumOrderQuantity = minimumOrderQuantity
        self.meta = meta
        self.images = images
        self.thumbnail = thumbnail
    }
}
