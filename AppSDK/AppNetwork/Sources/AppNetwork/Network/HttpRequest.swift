import Foundation

public enum HttpMethod: String {
    case GET, POST, PUT, DELETE
}

public struct HttpRequest {
    public var method: HttpMethod
    public var path: String
    public var queryItems: [URLQueryItem] = []
    public var headers: [String: String] = [:]
    public var body: HTTPBody? = nil
    public var decoder: JSONDecoder

    public init(
        method: HttpMethod,
        path: String,
        queryItems: [URLQueryItem] = [],
        headers: [String: String] = [:],
        body: HTTPBody? = nil,
        decoder: JSONDecoder = .init()
    ) {
        self.method = method
        self.path = path
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
        self.decoder = decoder
    }
}

public enum HTTPBody {
    case data(Data, contentType: String?)
    case json(Encodable, encoder: JSONEncoder = JSONEncoder())
    case form([String: String]) // application/x-www-form-urlencoded
}
