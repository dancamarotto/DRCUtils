import XCTest
import Combine
@testable import DRCUtils

class DRCUtilsTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    func testGet() {
        let network = DCNetwork()
        let mockExpectation = expectation(description: "mock object")
        let completionExpectation = expectation(description: "completion")
        
        fetchMock(network)
            .sink { completion in
                XCTAssertEqual(completion, .finished)
                completionExpectation.fulfill()
            } receiveValue: { mock in
                XCTAssertEqual(mock.id, 1)
                XCTAssertEqual(mock.title, "delectus aut autem")
                mockExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [mockExpectation, completionExpectation], timeout: 3.0)
    }
    
    func testValidURL() {
        let finalUrl = "https://myapi.com/users?token=123456&query=swift%20ios"
        let url = "https://myapi.com"
        let param1 = URLQueryItem(name: "token", value: "123456")
        let param2 = URLQueryItem(name: "query", value: "swift ios")
        let request = DCNetworkRequestBuilder()
            .setPath("/users")
            .appendQueryItems([param1, param2])
            .createRequest(url: url)
        
        XCTAssertEqual(request?.url?.absoluteString, finalUrl)
    }
    
    private func fetchMock(_ network: DCNetwork) -> Future<Mock, NetworkError> {
        let url = "https://jsonplaceholder.typicode.com"
        let builder = DCNetworkRequestBuilder()
            .setPath("/todos/1")
        return network.request(url: url, parameterBuilder: builder)
    }
    
    func testURLConvertible() {
        let urlString = "https://someurl.com"
        let url = URL(string: urlString)
        
        let stringAsUrl = urlString.asURL()
        XCTAssertEqual(url, stringAsUrl)
        
        let urlAsUrl = url?.asURL()
        XCTAssertEqual(url, urlAsUrl)
    }
}

struct Mock: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
