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
}

protocol HTTPClient {}

final class RemoteNodeLoaderTests: XCTestCase {
    
    func test_init_doesNotMakeAPIRequest() {
        let client = HTTPClientSpy()
        let sut = RemoteNodeLoader(client: client)
        
        XCTAssertNil(client.receveidMessages)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var receveidMessages: Any? = nil
    }
}
