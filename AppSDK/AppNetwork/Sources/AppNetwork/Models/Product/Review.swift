import Foundation

// MARK: - Review
public struct Review: Codable, Hashable, Sendable {
    public let rating: Int
    public let comment: String
    public let date: Date
    public let reviewerName: String
    public let reviewerEmail: String

    public init(
        rating: Int,
        comment: String,
        date: Date,
        reviewerName: String,
        reviewerEmail: String
    ) {
        self.rating = rating
        self.comment = comment
        self.date = date
        self.reviewerName = reviewerName
        self.reviewerEmail = reviewerEmail
    }
}
