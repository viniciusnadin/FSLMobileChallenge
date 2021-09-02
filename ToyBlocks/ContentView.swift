//
//  ContentView.swift
//  ToyBlocks
//
//  Created by FullStack Labs on 01/09/21.
//

import SwiftUI


struct ContentView: View {
    @StateObject var settings = AppSettings()
    @ObservedObject var nodeList = NodeList()
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack() {
                ScreenTitleView(title: "Nodes").padding(.top, 50)
                ScrollView {
                    ForEach(nodeList.nodes) { node in
                        NodeCardView(node)
                    }
                }
                Spacer()
            }.padding(.horizontal, settings.horizontalPadding)
        }
        .preferredColorScheme(.light)
        .onAppear {
            self.nodeList.refresh()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}