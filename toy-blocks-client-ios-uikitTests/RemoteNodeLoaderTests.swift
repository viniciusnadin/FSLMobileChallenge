//
//  RemoteNodeLoaderTests.swift
//  toy-blocks-client-ios-uikitTests
//
//  Created by Vinicius Nadin on 11/03/23.
//

import XCTest

class RemoteNodeLoader {
    private let client: HTTPClient
    typealias Result = Swift.Result<Void, Error>
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func loadNodeBlock(from url: URL, completion: @escaping (Result) -> Void) {
        client.get(from: url, completion: completion)
    }
}

protocol HTTPClient {
    typealias Result = Swift.Result<Void, Error>
    
    func get(from url: URL, completion: @escaping (Result) -> Void)
}

final class RemoteNodeLoaderTests: XCTestCase {
    
    func test_init_doesNotMakeAPIRequest() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_loadNodeBlock_requestsDataFromURL() {
        let (sut, client) = makeSUT()
        let url = anyURL
        
        sut.loadNodeBlock(from: url) { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadNodeBlock_requestsDataFromURLTwice() {
        let (sut, client) = makeSUT()
        let url = anyURL
        
        sut.loadNodeBlock(from: url) { _ in }
        sut.loadNodeBlock(from: url) { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_loadNodeBlock_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        let url = anyURL
        let error = NSError(domain: "Error", code: 0)
        
        let exp = expectation(description: "Wait for loadNodeBlock completion")
        sut.loadNodeBlock(from: url) { response in
            switch response {
            case .success:
                XCTFail("Expected failure result, got success instead")
            case let .failure(receivedError):
                XCTAssertEqual(receivedError as NSError, error)
            }
            exp.fulfill()
        }
        
        client.complete(withError: error)
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Helpers
    private func makeSUT() -> (sut: RemoteNodeLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteNodeLoader(client: client)
        return (sut, client)
    }
    
    private var anyURL: URL = {
        URL(string: "http://any-url.com")!
    }()
    
    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (HTTPClient.Result) -> Void)]()
        
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(withError error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
    }
}
