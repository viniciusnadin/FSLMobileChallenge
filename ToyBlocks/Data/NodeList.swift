//
//  NodeList.swift
//  ToyBlocks
//
//  Created by FullStack Labs on 02/09/21.
//

import SwiftUI

class NodeList: ObservableObject {
    @Published var nodes: [Node] = [
        Node("Node 1", "https://thawing-springs-53971.herokuapp.com"),
        Node("Node 2", "https://secret-lowlands-62331.herokuapp.com"),
        Node("Node 3", "https://calm-anchorage-82141.herokuapp.com"),
        Node("Node 4", "http://localhost:3002")
    ]
    
    public func refresh() -> Void {
        for node in self.nodes {
            self.refreshNode(node)
        }
    }
    
    private func refreshNode(_ node: Node) -> Void {
        var request = URLRequest(url: URL(string: "\(node.url)/api/v1/status")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            DispatchQueue.main.async {
                node.loading = false

                if data != nil {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                        node.name = String(describing: json["node_name"])
                        node.online = true
                    } catch {
                        print(error)
                    }
                }
            }
        })
        
        task.resume()
    }
}
