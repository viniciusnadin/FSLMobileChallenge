//
//  RemoteNodeLoaderTests.swift
//  toy-blocks-client-ios-uikitTests
//
//  Created by Vinicius Nadin on 11/03/23.
//

import XCTest

class RemoteNodeLoader {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func loadNodeBlock(from url: URL) {
        client.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

final class RemoteNodeLoaderTests: XCTestCase {
    
    func test_init_doesNotMakeAPIRequest() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.receivedURLs.isEmpty)
    }
    
    func test_loadNodeBlock_requestsDataFromURL() {
        let (sut, client) = makeSUT()
        let url = URL(string: "http://any-url.com")!
        
        sut.loadNodeBlock(from: url)
        
        XCTAssertEqual(client.receivedURLs, [url])
    }
    
    func test_loadNodeBlock_requestsDataFromURLTwice() {
        let (sut, client) = makeSUT()
        let url = URL(string: "http://any-url.com")!
        
        sut.loadNodeBlock(from: url)
        sut.loadNodeBlock(from: url)
        
        XCTAssertEqual(client.receivedURLs, [url, url])
    }
    
    // MARK: - Helpers
    private func makeSUT() -> (sut: RemoteNodeLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteNodeLoader(client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var receivedURLs: [URL] = [URL]()
        
        func get(from url: URL) {
            receivedURLs.append(url)
        }
    }
}
