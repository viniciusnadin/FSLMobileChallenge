//
//  Node.swift
//  ToyBlocks
//
//  Created by FullStack Labs on 02/09/21.
//

import Foundation

class Node: Identifiable, ObservableObject {
    let id = UUID()
    
    @Published public var loading: Bool
    @Published public var name: String
    @Published public var online: Bool
    @Published public var url: String
    
    init(_ name: String, _ url: String) {
        self.loading = true
        self.name = name
        self.online = false
        self.url = url
    }
}
