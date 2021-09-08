//
//  NodeListTest.swift
//  ToyBlocksTests
//
//  Created by FullStack Labs on 03/09/21.
//

import XCTest
@testable import ToyBlocks

class NodeListTest: XCTestCase {
    var apiProvider: ApiProvider!
    
    override func setUp() {
        let urlSessionConfig = URLSessionConfiguration.ephemeral
        urlSessionConfig.protocolClasses = [URLProtocolMock.self]
        
        let session = URLSession(configuration: urlSessionConfig)
        self.apiProvider = ApiProvider(using: session)
    }
    
    func testNodeListHasAtLeastOneNode() {
        XCTAssertGreaterThan(NodeList().nodes.count, 0)
    }
    
    func testNodesHaveURL() {
        let nodeList = NodeList()
        
        for node in nodeList.nodes {
            XCTAssertNotNil(node.url)
            XCTAssertTrue(node.url.contains("http://") || node.url.contains("https://"))
        }
    }

    func testNodesAreFetching() {
        URLProtocolMock.mockData = Data("{ \"node_name\": \"AnyServer\" }".utf8)
        let expectation = XCTestExpectation(description: "Fetching nodes statuses")
        
        let nodeList = NodeList(apiProvider: self.apiProvider)
        
        nodeList.fetchStatuses(completionHandler: {
            for node in nodeList.nodes {
                XCTAssertEqual(node.name, "AnyServer")
                XCTAssertTrue(node.online)
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5)
    }
}

