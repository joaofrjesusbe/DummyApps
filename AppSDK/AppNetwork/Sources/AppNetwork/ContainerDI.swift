import Foundation
import AppCore
import Nuke

public extension Container {
    var networkMode: Factory<NetworkMode> {
        self { .auto }.singleton
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

    var httpClient: Factory<HttpClientType> {
        self {
            guard let baseURL = URL(string: "https://dummyjson.com") else { fatalError("Bad baseURL") }
            return HttpClient(baseURL: baseURL, networkRequest: self.networkPipeline.resolve())
        }
        .singleton
    }

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
