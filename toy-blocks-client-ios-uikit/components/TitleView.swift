//
//  Title.swift
//  toy-blocks-client-ios-uikit
//
//  Created by Thiago Galvani on 23/06/22.
//

import UIKit

class TitleView: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        text = "Nodes"
        textColor = UIColor.black
        font = UIFont(name: "Roboto-Bold", size: 34)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
