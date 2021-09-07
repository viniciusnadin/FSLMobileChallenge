//
//  NodeList.swift
//  ToyBlocks
//
//  Created by FullStack Labs on 02/09/21.
//

import SwiftUI

class NodeList: ObservableObject {
    private var apiProvider: ApiProvider!
    
    @Published var nodes: [Node] = [
        Node("Node 1", "https://thawing-springs-53971.herokuapp.com"),
        Node("Node 2", "https://secret-lowlands-62331.herokuapp.com"),
        Node("Node 3", "https://calm-anchorage-82141.herokuapp.com"),
        Node("Node 4", "http://localhost:3002")
    ]
    
    convenience init() {
        self.init(apiProvider: ApiProvider())
    }

    init(apiProvider: ApiProvider) {
        self.apiProvider = apiProvider
    }

    public func fetchStatuses() -> Void {
        for node in self.nodes {
            let url: String = "\(node.url)/api/v1/status"
            self.fetchNodeStatus(url: url, node: node)
        }
    }

    private func fetchNodeStatus(url: String, node: Node) -> Void {
        let url: String = "\(node.url)/api/v1/status"

        self.apiProvider.get(url: url, completionHandler: { json, error in
            DispatchQueue.main.async {
                node.loading = false

                if json != nil {
                    node.name = String(describing: json!["node_name"]!)
                    node.online = true
                }
                else {
                    node.online = false
                    print(error!)
                }
            }
        })
    }
}
