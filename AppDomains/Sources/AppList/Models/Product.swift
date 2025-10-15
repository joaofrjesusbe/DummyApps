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
    public let thumbnail: URL?
    public let images: [URL]
}
