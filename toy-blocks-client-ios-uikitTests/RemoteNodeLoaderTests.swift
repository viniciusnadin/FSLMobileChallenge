//
//  RemoteNodeLoaderTests.swift
//  toy-blocks-client-ios-uikitTests
//
//  Created by Vinicius Nadin on 11/03/23.
//

import XCTest

class RemoteNodeLoader {
    private let client: HTTPClient
    
    enum Error: Swift.Error {
        case client
        case invalidData
    }
    
    typealias Result = Swift.Result<[NodeBlock], Swift.Error>
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func loadNodeBlock(from url: URL, completion: @escaping (Result) -> Void) {
        client.get(from: url) { result in
            switch result {
            case let .success(data):
                completion(RemoteNodeLoader.map(data: data))
            case .failure:
                completion(.failure(Error.client))
            }
        }
    }
    
    private static func map(data: Data) -> Result {
        do {
            let blocks = try NodeBlocksMapper.map(data)
            return .success(blocks.toModels())
        } catch {
            return .failure(error)
        }
    }
}

private extension Array where Element == RemoteNodeBlock {
    func toModels() -> [NodeBlock] {
        map { NodeBlock(index: $0.attributes.index, content: $0.attributes.data)}
    }
}

struct RemoteNodeBlock: Decodable {
    let attributes: Attributes
    
    struct Attributes: Decodable {
        let index: Int
        let data: String
    }
}

class NodeBlocksMapper {
    private struct Root: Decodable {
        let data: [RemoteNodeBlock]
    }
    
    static func map(_ data: Data) throws -> [RemoteNodeBlock] {
        guard let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw RemoteNodeLoader.Error.invalidData
        }
        return root.data
    }
}

struct NodeBlock: Equatable {
    let index: Int
    let content: String
}

protocol HTTPClient {
    typealias Result = Swift.Result<Data, Error>
    
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
        let error = RemoteNodeLoader.Error.client
        
        expect(sut, toCompleteWith: .failure(error)) {
            client.complete(withError: error)
        }
    }
    
    func test_loadNodeBlock_deliversBlocksOnClientSuccess() {
        let (sut, client) = makeSUT()
        let node1 = makeNodeBlock(index: 1, content: "The Human Torch")
        
        expect(sut, toCompleteWith: .success([node1.model])) {
            let data = makeNodeBlocksJSON([node1.json])
            client.complete(withData: data)
        }
    }
    
    // MARK: - Helpers
    private func makeSUT() -> (sut: RemoteNodeLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteNodeLoader(client: client)
        return (sut, client)
    }
    
    private func expect(_ sut: RemoteNodeLoader, toCompleteWith expectedResult: RemoteNodeLoader.Result, when action: () -> Void) {
        let exp = expectation(description: "Wait for loadNodeBlock completion")
        
        sut.loadNodeBlock(from: anyURL) { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedBlocks), .success(expectedBlocks)):
                XCTAssertEqual(receivedBlocks, expectedBlocks)
            case let (.failure(receivedError), .failure(expectedError)):
                XCTAssertEqual(receivedError as NSError, expectedError as NSError)
            default:
                XCTFail("Expected \(expectedResult), got \(receivedResult) instead")
            }
            exp.fulfill()
        }
        
        action()
        wait(for: [exp], timeout: 1.0)
    }
    
    private func makeNodeBlock(index: Int, content: String) -> (model: NodeBlock, json: [String: Any]) {
        let model = NodeBlock(index: index, content: content)
        
        let json: [String: Any] = [
            "id": "7",
            "type": "blocks",
            "attributes": [
                "index": 1,
                "timestamp": 1530679678,
                "data": "The Human Torch",
                "previous-hash": "KsmmdGrKVDr43/OYlM/ofzr7oh6wHG+uM9UpRyIoVe8=",
                "hash": "oHkxOJWOKy02vA9r4iRHVqTgqT+Afc6OYFcNYzyhGEc="
            ]
        ]
        
        return (model, json)
    }
    
    private func makeNodeBlocksJSON(_ blocks: [[String:Any]]) -> Data {
        let json = ["data":blocks]
        return try! JSONSerialization.data(withJSONObject: json)
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
        
        func complete(withData data: Data, at index: Int = 0) {
            messages[index].completion(.success(data))
        }
    }
}
