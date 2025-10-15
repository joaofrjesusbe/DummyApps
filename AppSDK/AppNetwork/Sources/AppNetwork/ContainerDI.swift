import Foundation
import AppCore
import Nuke

extension Container {
    var networkMode: Factory<NetworkMode> {
        self { .live }.singleton
    }
    
    var cassettePipelineFactory: Factory<CassettePipelineFactory> {
        self {
            CassettePipelineFactory(
                networkMode: self.networkMode.resolve(),
                mainRequest: NetworkSessionRequest()
            )
        }.singleton
    }
    
    var networkPipeline: Factory<NetworkRequest> {
        self {
            let factory = self.cassettePipelineFactory.resolve()
            return factory.createCasseteNetwork(
                requestInterceptors: [
                    NetworkLoggerInterceptor()
                ],
                responseInterceptors: []
            )
        }
        .singleton
    }
    
    public var httpClient: Factory<HttpClientType> {
        self {
            guard let baseURL = URL(string: "https://dummyjson.com") else { fatalError("Bad baseURL") }
            return HttpClient(baseURL: baseURL, networkRequest: self.networkPipeline.resolve())
        }
        .singleton
    }
}

public extension Container {
    /// High-level loader API used by UI layers.
    var imageLoader: Factory<ImageLoader> {
        self {
            let nukeImagePipeline = ImagePipeline { config in
                
                let factory = self.cassettePipelineFactory.resolve()
                let network = factory.createOriginalNetwork()
                let nukeDataLoader = NukeDataLoader(network: network)
                
                config.dataLoader = nukeDataLoader
                config.dataCachePolicy = .automatic
            }
            
            return ImageLoader(pipeline: nukeImagePipeline)
        }.singleton
    }
}
