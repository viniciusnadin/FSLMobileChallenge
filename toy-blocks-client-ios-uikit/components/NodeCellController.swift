//
//  NodeCellController.swift
//  toy-blocks-client-ios-uikit
//
//  Created by Vinicius Nadin on 12/03/23.
//

import UIKit

final class NodeCellController {
    
    // MARK: - CustomErrors
    enum Error: Swift.Error {
        case offlinePath
        case invalidData
    }
    
    // MARK: - Attributes
    private let model: Node
    private let loader: RemoteNodeLoader
    
    // MARK: - Initializer
    init(model: Node, loader: RemoteNodeLoader) {
        self.model = model
        self.loader = loader
    }
    
    // MARK: - Public Methods
    func view(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NodeTableViewCell.identifier,
            for: indexPath) as? NodeTableViewCell
        else {
            fatalError("Error fetching dequeued reusable cell!")
        }
        
        cell.configure(node: model)
        
        if model.blocks.isEmpty && model.online {
            loadBlocks { result in
                switch result {
                case let .success(blocks):
                    DispatchQueue.main.async {
                        cell.add(nodeBlocks: blocks)
                    }
                case .failure:
                    break
                }
            }
        } else {
            cell.add(nodeBlocks: model.blocks)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func loadBlocks(completion: @escaping (Result<[NodeBlock], Error>) -> Void ) {
        guard let url = URL(string: model.url), model.online else {
            return completion(.failure(.offlinePath))
        }
        
        loader.loadNodeBlock(from: url) { result in
            switch result {
            case let .success(blocks):
                completion(.success(blocks))
            case .failure:
                completion(.failure(.invalidData))
            }
        }
    }
}
