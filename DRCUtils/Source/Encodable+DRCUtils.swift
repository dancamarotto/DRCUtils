import Foundation

extension Encodable {
    internal func encode() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
