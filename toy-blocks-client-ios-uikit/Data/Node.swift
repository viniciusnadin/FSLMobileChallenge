//
//  Node.swift
//  ToyBlocks
//
//  Created by Thiago Galvani on 22/06/22.
//

import Foundation

class Node: Identifiable {
    
    let id = UUID()
    var loading: Bool
    var name: String
    var online: Bool
    var url: String
    var blocks: [NodeBlock] = [NodeBlock]()
    
    init(_ name: String, _ url: String) {
        self.loading = true
        self.name = name
        self.online = false
        self.url = url
    }
}
