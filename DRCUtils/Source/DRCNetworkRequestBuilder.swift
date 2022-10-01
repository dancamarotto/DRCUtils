import Foundation

public class DCNetworkRequestBuilder {
    private var httpMethod: HTTPMethod
    private var path: String?
    private var queryItems = [URLQueryItem]()
    private var header = RequestHeaders()
    private var body: Encodable?
    private var timeout: Float = 5.0
    
    public init() {
        httpMethod = .get
    }
    
    @discardableResult
    public func setPath(_ path: String) -> DCNetworkRequestBuilder {
        self.path = path
        return self
    }
    
    @discardableResult
    public func appendQueryItems(_ queryItems: [URLQueryItem]) -> DCNetworkRequestBuilder {
        self.queryItems.append(contentsOf: queryItems)
        return self
    }
    
    @discardableResult
    public func setMethod(_ method: HTTPMethod) -> DCNetworkRequestBuilder {
        httpMethod = method
        return self
    }
    
    @discardableResult
    public func setHeaders(_ headers: RequestHeaders) -> DCNetworkRequestBuilder {
        header = headers
        return self
    }
    
    @discardableResult
    public func appendHeaders(_ headers: RequestHeaders) -> DCNetworkRequestBuilder {
        headers.forEach {
            header[$1] = $0
        }
        return self
    }
    
    @discardableResult
    public func setBody(_ body: Encodable) -> DCNetworkRequestBuilder {
        self.body = body
        return self
    }
    
    @discardableResult
    public func setBody(_ body: RequestParameters) -> DCNetworkRequestBuilder {
        do {
            self.body = try JSONSerialization.data(withJSONObject: body,
                                                   options: .prettyPrinted)
        } catch let error {
            debugPrint(error.localizedDescription)
            self.body = nil
        }
        return self
    }
    
    @discardableResult
    public func setTimeout(_ timeout: Float) -> DCNetworkRequestBuilder {
        self.timeout = timeout
        return self
    }
    
    internal func createRequest(url: URLConvertible) -> URLRequest? {
        guard var urlComponents = URLComponents(urlConvertible: url) else { return nil }
        
        if let path = path {
            urlComponents.path = path
        }
        queryItems.forEach { queryItem in
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = header
        
        return urlRequest
    }
}
