//
//  NodeCardStatusView.swift
//  ToyBlocks
//
//  Created by FullStack Labs on 02/09/21.
//

import SwiftUI

struct NodeCardStatusView: View {
    @Binding var isOnline: Bool
    
    private let size: CGFloat = 8
    
    var body: some View {
        HStack {
            Spacer()
            if isOnline {
                Circle().fill(Color(.green)).frame(width: size, height: size)
                Text("ONLINE").font(.system(size: size)).fontWeight(.bold)
            }
            else {
                Circle().fill(Color(.red)).frame(width: size, height: size)
                Text("OFFLINE").font(.system(size: size)).fontWeight(.bold).foregroundColor(Color("DisabledTextColor"))
            }
        }
    }
}

struct NodeCardStatusView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NodeCardStatusView(isOnline: .constant(false))
            NodeCardStatusView(isOnline: .constant(true))
        }.previewLayout(.sizeThatFits)
    }
}
