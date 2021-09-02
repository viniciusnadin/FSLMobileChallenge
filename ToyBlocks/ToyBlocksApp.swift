//
//  ToyBlocksApp.swift
//  ToyBlocks
//
//  Created by Moacir Braga on 01/09/21.
//

import SwiftUI

@main
struct ToyBlocksApp: App {
    @EnvironmentObject var settings: AppSettings
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
