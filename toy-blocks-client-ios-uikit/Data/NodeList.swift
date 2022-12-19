//
//  NodeList.swift
//  toy-blocks-client-ios-uikit
//
//  Created by Thiago Galvani on 22/06/22.
//

import SwiftUI

class NodeList: ObservableObject {
    private var apiProvider: ApiProvider!
    
    @Published var nodes: [Node] = [
        Node("Node 1", "https://fsl-assessment-toy-blocks-node-01.s3.amazonaws.com"),
        Node("Node 2", "https://fsl-assessment-toy-blocks-node-02.s3.amazonaws.com"),
        Node("Node 3", "https://fsl-assessment-toy-blocks-node-03.s3.amazonaws.com"),
        Node("Node 4", "http://localhost:3002")
    ]
    
    convenience init() {
        self.init(apiProvider: ApiProvider())
    }

    init(apiProvider: ApiProvider) {
        self.apiProvider = apiProvider
    }

    public func fetchStatuses(completionHandler: @escaping () -> Void = { }) -> Void {
        let taskGroup = DispatchGroup()
        
        for node in self.nodes {
            let url: String = "\(node.url)/api/v1/status"

            taskGroup.enter()
            self.fetchNodeStatus(url: url, node: node, completionHandler: {
                taskGroup.leave()
            })
        }
        
        taskGroup.notify(queue: .main) {
            completionHandler()
        }
    }

    private func fetchNodeStatus(url: String, node: Node, completionHandler: @escaping () -> Void) -> Void {
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
                
                completionHandler()
            }
        })
    }
}

