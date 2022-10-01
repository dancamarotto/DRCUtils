import Foundation

public protocol URLConvertible {
    func asURL() -> URL?
}

// MARK: - String

extension String: URLConvertible {
    public func asURL() -> URL? {
        URL(string: self)
    }
}

// MARK: - URL

extension URL: URLConvertible {
    public func asURL() -> URL? {
        self
    }
}

// MARK: URLComponents

extension URLComponents {
    public init?(urlConvertible: URLConvertible) {
        guard let url = urlConvertible.asURL(),
              let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        self = urlComponents
    }
}
