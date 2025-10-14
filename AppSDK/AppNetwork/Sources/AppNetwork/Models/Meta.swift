import Foundation

// MARK: - Meta
public struct Meta: Codable, Sendable {
    public let createdAt: Date
    public let updatedAt: Date
    public let barcode: String
    public let qrCode: URL

    public init(createdAt: Date, updatedAt: Date, barcode: String, qrCode: URL) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.barcode = barcode
        self.qrCode = qrCode
    }
}
