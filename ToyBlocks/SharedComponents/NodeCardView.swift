//
//  NodeCardView.swift
//  ToyBlocks
//
//  Created by FullStack Labs on 02/09/21.
//

import SwiftUI

struct NodeCardView: View {
    @ObservedObject var node: Node
    @State private var isExpanded = false

    init(_ node: Node) {
        self.node = node
    }
    
    var body: some View {
        ZStack {
            Color("SurfaceBackgroundColor").shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 3)
            VStack(alignment: .leading) {
                HStack {
                    Text(self.node.name).font(.subheadline).foregroundColor(Color("PrimaryTextColor"))
                    
                    Spacer()
                    
                    if node.loading {
                        LoaderView()
                    }
                    else {
                        NodeCardStatusView(isOnline: $node.online)
                    }
                }

                Text(self.node.url)
                    .font(.caption).foregroundColor(Color("PrimaryTextColor")).opacity(0.54)
                
                if isExpanded {
                    Group {
                        Text("Blocks go here").font(.subheadline).foregroundColor(.red)
                    }.padding(.top, 10)
                }
            }
            .padding(.all, 10)
        }
        .onTapGesture {
            self.isExpanded.toggle()
        }
        .padding(.bottom, 2)
    }
}

#if !TESTING
struct NodeCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            NodeCardView(NodeList().nodes[0]).previewLayout(.sizeThatFits)
        }
    }
}
#endif
