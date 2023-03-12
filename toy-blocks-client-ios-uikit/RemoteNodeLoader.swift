//
//  RemoteNodeLoader.swift
//  toy-blocks-client-ios-uikit
//
//  Created by Vinicius Nadin on 11/03/23.
//

import Foundation

public class RemoteNodeLoader {
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
        let blocksURL = url.appendingPathComponent("/api/v1/blocks", conformingTo: .url)
        client.get(from: blocksURL) { result in
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

protocol HTTPClient {
    typealias Result = Swift.Result<Data, Error>
    
    func get(from url: URL, completion: @escaping (Result) -> Void)
}
