//
//  URLProtocolMock.swift
//  ToyBlocksTests
//
//  Created by FullStack Labs on 07/09/21.
//

import Foundation

class URLProtocolMock: URLProtocol {
    static var mockData: Data?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        self.client?.urlProtocol(self, didLoad: URLProtocolMock.mockData ?? Data())
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}
