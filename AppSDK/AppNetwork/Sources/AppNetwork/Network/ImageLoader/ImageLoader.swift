import Nuke
import Foundation

public protocol ImageLoadable {
    
    func image(for url: URL) async throws -> PlatformImage
}

public struct ImageLoader: ImageLoadable {
    private let pipeline: ImagePipeline

    public init(pipeline: ImagePipeline) {
        self.pipeline = pipeline
    }

    public func image(for url: URL) async throws -> PlatformImage {
        try await pipeline.image(for: url)
    }
}
