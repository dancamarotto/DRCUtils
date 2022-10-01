public enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case badRequest
    case serverError
    case unableToParseJSON(String)
    case jsonSerialization(String)
    case unknown
}
