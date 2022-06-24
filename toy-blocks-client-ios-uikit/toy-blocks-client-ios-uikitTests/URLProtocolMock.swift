//
//  URLProtocolMock.swift
//  toy-blocks-client-ios-uikitTests
//
//  Created by Thiago Galvani on 24/06/22.
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
