import Foundation
import AppGroup

@MainActor
protocol ProductsListProvidable {
    func bootstrap() async throws -> [Product]
    func refreshFromNetworkIfNeeded() async throws -> [Product]
    func getCached() async -> [Product]
}
