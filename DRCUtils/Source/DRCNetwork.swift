import Foundation
import Combine

// MARK: - Declarations.swift

public typealias RequestHeaders = [String: String]

public typealias RequestParameters = [String: Any?]

// MARK: - DCNetwork

public class DCNetwork {
    public init() { }
    
    public func request<T>(url: URLConvertible,
                           parameterBuilder: DCNetworkRequestBuilder = DCNetworkRequestBuilder(),
                           decoder: JSONDecoder = JSONDecoder()) -> Future<T, NetworkError> where T: Decodable {
        Future { promise in
            guard let request = parameterBuilder.createRequest(url: url) else {
                return promise(.failure(.invalidURL))
            }
            
            URLSession
                .shared
                .dataTask(with: request) { data, response, _ in
                    guard let response = response as? HTTPURLResponse else {
                        return promise(.failure(.invalidResponse))
                    }
                    
                    switch response.statusCode {
                    case 200...299:
                        break
                    case 400...499:
                        return promise(.failure(.badRequest))
                    case 500...599:
                        return promise(.failure(.serverError))
                    default:
                        return promise(.failure(.unknown))
                    }
                    
                    guard let data = data else {
                        return promise(.failure(.invalidResponse))
                    }
                    
                    do {
                        let object = try decoder.decode(T.self, from: data)
                        return promise(.success(object))
                    } catch (let error) {
                        return promise(.failure(.unableToParseJSON(error.localizedDescription)))
                    }
                }
                .resume()
        }
    }
}
