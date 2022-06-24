//
//  Node.swift
//  ToyBlocks
//
//  Created by Thiago Galvani on 22/06/22.
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
