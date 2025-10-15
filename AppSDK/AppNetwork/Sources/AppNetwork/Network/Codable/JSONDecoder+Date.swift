import Foundation

public extension JSONDecoder {
    static let iso8601WithFractionalSeconds: JSONDecoder = {
        let decoder = JSONDecoder()
        if #available(iOS 11.0, macOS 10.13, tvOS 11.0, watchOS 4.0, *) {
            decoder.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let string = try container.decode(String.self)

                // Create formatters inside the closure to avoid capturing non-Sendable state
                let primary = ISO8601DateFormatter()
                primary.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                if let date = primary.date(from: string) {
                    return date
                }

                let fallback = ISO8601DateFormatter()
                fallback.formatOptions = [.withInternetDateTime]
                if let date = fallback.date(from: string) {
                    return date
                }

                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Invalid ISO8601 date: \(string)"
                )
            }
        }
        return decoder
    }()
}

