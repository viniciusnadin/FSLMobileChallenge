//
//  ScreenTitleView.swift
//  ToyBlocks
//
//  Created by FullStack Labs on 02/09/21.
//

import SwiftUI

struct ScreenTitleView: View {
    var title: String

    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack {
            Text(self.title)
                .font(.title).fontWeight(.bold)
                
            Spacer()
        }
    }
}

#if !TESTING
struct ScreenTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenTitleView(title: "Nodes").previewLayout(.sizeThatFits)
    }
}
#endif
