//
//  LoaderView.swift
//  ToyBlocks
//
//  Created by FullStack Labs on 02/09/21.
//

import SwiftUI

struct LoaderView: View {
    private var size: CGFloat = 8
    
    @State private var isAnimating = false
    
    var body: some View {
        Circle()
            .fill(Color("AccentColor"))
            .frame(width: size, height: size)
            .scaleEffect(self.isAnimating ? 0.5 : 1)
            .animation(Animation.linear(duration: 1).repeatForever())
            .onAppear {
                self.isAnimating = true
            }
    }
}

#if !TESTING
struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
#endif
